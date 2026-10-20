#!/usr/bin/env node
/**
 * Regera os PDFs do currículo a partir do index.html, igual ao "Salvar como PDF" do Chrome.
 *
 *   node scripts/gerar-pdfs.mjs            # gera PT e EN
 *   node scripts/gerar-pdfs.mjs pt         # só um idioma
 *   CHROME_PATH=/caminho/do/chrome node scripts/gerar-pdfs.mjs
 *   node scripts/gerar-pdfs.mjs --permitir-fallback   # gera mesmo sem a IBM Plex
 *
 * Sem dependências: abre o Brave/Chrome/Chromium instalado em modo headless e conversa com
 * ele pelo DevTools Protocol usando o WebSocket nativo do Node (>= 22).
 * Precisa de internet para carregar a IBM Plex do Google Fonts. Sem ela o script
 * para: a fonte de fallback entra no PDF como Type 3, que parsers de ATS leem mal.
 */
import { spawn, execFileSync } from 'node:child_process'
import { existsSync } from 'node:fs'
import { mkdtemp, rm, writeFile } from 'node:fs/promises'
import { tmpdir } from 'node:os'
import { join, dirname, resolve } from 'node:path'
import { fileURLToPath, pathToFileURL } from 'node:url'

// Funciona com o script em scripts/ ou na raiz do repositório
const HERE = dirname(fileURLToPath(import.meta.url))
const ROOT = [HERE, resolve(HERE, '..')].find((dir) => existsSync(join(dir, 'index.html')))
if (!ROOT) {
  console.error(`✗ index.html não encontrado em ${HERE} nem na pasta acima.`)
  process.exit(1)
}
const PAGE = pathToFileURL(join(ROOT, 'index.html'))

const OUTPUTS = {
  pt: 'curriculo-rodrigo-soares.pdf',
  en: 'resume-rodrigo-soares.pdf',
}

const TIMEOUT_MS = 30_000

/* ---------- Chrome ---------- */

function findChrome() {
  if (process.env.CHROME_PATH) return process.env.CHROME_PATH
  // Qualquer navegador baseado em Chromium serve (Brave: pacote apt "brave-browser"; snap "brave")
  const candidates = [
    'brave-browser',
    'brave-browser-stable',
    'brave',
    'google-chrome-stable',
    'google-chrome',
    'chromium',
    'chromium-browser',
  ]
  for (const bin of candidates) {
    try {
      return execFileSync('which', [bin], { encoding: 'utf8' }).trim()
    } catch {}
  }
  throw new Error(
    'Brave/Chrome/Chromium não encontrado. Instale um deles ou defina CHROME_PATH.',
  )
}

async function launchChrome() {
  const profile = await mkdtemp(join(tmpdir(), 'cv-pdf-'))
  const chrome = spawn(
    findChrome(),
    [
      '--headless=new',
      '--remote-debugging-port=0',
      `--user-data-dir=${profile}`,
      '--no-first-run',
      '--no-default-browser-check',
      '--disable-extensions',
      // Como root (ex.: dentro de container) o Chrome só sobe sem sandbox
      ...(process.getuid?.() === 0 ? ['--no-sandbox'] : []),
      'about:blank',
    ],
    { stdio: ['ignore', 'ignore', 'pipe'] },
  )

  // O Chrome anuncia o endereço do DevTools no stderr
  const wsUrl = await new Promise((ok, fail) => {
    let log = ''
    const timer = setTimeout(() => fail(new Error(`Chrome não respondeu:\n${log}`)), TIMEOUT_MS)
    chrome.stderr.on('data', (chunk) => {
      log += chunk
      const match = log.match(/DevTools listening on (ws:\/\/\S+)/)
      if (match) {
        clearTimeout(timer)
        ok(match[1])
      }
    })
    chrome.once('exit', (code) => fail(new Error(`Chrome fechou (código ${code}):\n${log}`)))
    chrome.once('error', (err) => fail(new Error(`Não foi possível abrir o Chrome: ${err.message}`)))
  }).catch(async (err) => {
    await rm(profile, { recursive: true, force: true })
    throw err
  })

  async function close() {
    chrome.kill()
    await new Promise((ok) => (chrome.exitCode !== null ? ok() : chrome.once('exit', ok)))
    await rm(profile, { recursive: true, force: true })
  }

  return { wsUrl, close }
}

/* ---------- DevTools Protocol ---------- */

async function connect(wsUrl) {
  const ws = new WebSocket(wsUrl)
  await new Promise((ok, fail) => {
    ws.addEventListener('open', ok, { once: true })
    ws.addEventListener('error', () => fail(new Error('Falha ao conectar no DevTools')), {
      once: true,
    })
  })

  let nextId = 0
  const pending = new Map()
  const listeners = new Set()

  ws.addEventListener('message', ({ data }) => {
    const msg = JSON.parse(data)
    if (msg.id !== undefined) {
      const req = pending.get(msg.id)
      pending.delete(msg.id)
      if (msg.error) req?.fail(new Error(`${req.method}: ${msg.error.message}`))
      else req?.ok(msg.result)
    } else {
      listeners.forEach((fn) => fn(msg))
    }
  })

  function send(method, params = {}, sessionId) {
    const id = ++nextId
    ws.send(JSON.stringify({ id, method, params, sessionId }))
    return new Promise((ok, fail) => pending.set(id, { ok, fail, method }))
  }

  function waitFor(method, sessionId) {
    return new Promise((ok, fail) => {
      const timer = setTimeout(() => {
        listeners.delete(fn)
        fail(new Error(`Tempo esgotado esperando ${method}`))
      }, TIMEOUT_MS)
      const fn = (msg) => {
        if (msg.method === method && msg.sessionId === sessionId) {
          clearTimeout(timer)
          listeners.delete(fn)
          ok(msg.params)
        }
      }
      listeners.add(fn)
    })
  }

  return { send, waitFor, close: () => ws.close() }
}

/* ---------- Geração ---------- */

async function render(cdp, lang, allowFallback) {
  const { targetId } = await cdp.send('Target.createTarget', { url: 'about:blank' })
  const { sessionId } = await cdp.send('Target.attachToTarget', { targetId, flatten: true })
  const send = (method, params) => cdp.send(method, params, sessionId)
  const evaluate = async (expression) => {
    const { result, exceptionDetails } = await send('Runtime.evaluate', {
      expression,
      awaitPromise: true,
      returnByValue: true,
    })
    if (exceptionDetails) throw new Error(exceptionDetails.text)
    return result.value
  }

  await send('Page.enable')
  const loaded = cdp.waitFor('Page.loadEventFired', sessionId)
  await send('Page.navigate', { url: `${PAGE.href}?lang=${lang}` })
  await loaded

  // Fontes carregadas e idioma aplicado pelo script.js
  await evaluate('document.fonts.ready.then(() => true)')
  const state = await evaluate(`({
    lang: document.documentElement.dataset.lang,
    title: document.title,
    plex: [...document.fonts].some((f) => f.family.includes('IBM Plex Sans') && f.status === 'loaded'),
  })`)
  if (state.lang !== lang) throw new Error(`Página ficou em "${state.lang}", esperado "${lang}"`)
  if (!state.plex) {
    const msg = `IBM Plex não carregou (${lang}) — sem internet? A fonte de fallback sai como Type 3 no PDF.`
    if (!allowFallback) throw new Error(`${msg} Use --permitir-fallback para gerar mesmo assim.`)
    console.warn(`  ⚠ ${msg}`)
  }

  // Mesmo caminho do Ctrl+P: o beforeprint encerra as animações de entrada,
  // que bagunçariam a ordem de leitura do PDF
  await evaluate(`window.dispatchEvent(new Event('beforeprint')); true`)
  await send('Emulation.setEmulatedMedia', { media: 'print' })

  const { data } = await send('Page.printToPDF', {
    preferCSSPageSize: true, // usa o @page do style.css (margens)
    paperWidth: 8.27, // A4 em polegadas
    paperHeight: 11.69,
    printBackground: false,
    displayHeaderFooter: false,
    generateTaggedPDF: true, // PDF com estrutura (melhor para leitores de tela e parsers)
  })

  await cdp.send('Target.closeTarget', { targetId })
  return { pdf: Buffer.from(data, 'base64'), title: state.title }
}

async function main() {
  const args = process.argv.slice(2)
  const allowFallback = args.includes('--permitir-fallback')
  const picked = args.filter((a) => !a.startsWith('--'))
  const langs = picked.length ? picked : Object.keys(OUTPUTS)
  for (const lang of langs) {
    if (!OUTPUTS[lang]) throw new Error(`Idioma desconhecido: ${lang} (use: ${Object.keys(OUTPUTS).join(', ')})`)
  }

  const chrome = await launchChrome()
  const cdp = await connect(chrome.wsUrl)
  try {
    for (const lang of langs) {
      const { pdf, title } = await render(cdp, lang, allowFallback)
      const out = join(ROOT, OUTPUTS[lang])
      await writeFile(out, pdf)
      console.log(`✓ ${OUTPUTS[lang]}  (${(pdf.length / 1024).toFixed(0)} KB — ${title})`)
    }
  } finally {
    cdp.close()
    await chrome.close()
  }
}

main().catch((err) => {
  console.error(`✗ ${err.message}`)
  process.exit(1)
})
