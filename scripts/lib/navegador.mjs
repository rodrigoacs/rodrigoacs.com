/**
 * Base comum dos scripts: acha a raiz do site, abre um Brave/Chrome/Chromium headless
 * e conversa com ele pelo DevTools Protocol (WebSocket nativo do Node >= 22).
 * Sem dependências externas.
 */
import { spawn, execFileSync } from 'node:child_process'
import { existsSync } from 'node:fs'
import { mkdtemp, rm } from 'node:fs/promises'
import { tmpdir } from 'node:os'
import { join, dirname, resolve } from 'node:path'
import { fileURLToPath } from 'node:url'

const TIMEOUT_MS = 30_000

/* ---------- Raiz do site ---------- */

// Pasta onde está o index.html: a atual, ou subindo a partir de scripts/lib
export function findRoot() {
  const here = dirname(fileURLToPath(import.meta.url))
  const candidates = [process.cwd(), resolve(here, '..'), resolve(here, '..', '..')]
  const root = candidates.find((dir) => existsSync(join(dir, 'index.html')))
  if (!root) throw new Error(`index.html não encontrado (procurei em: ${candidates.join(', ')})`)
  return root
}

/* ---------- Navegador ---------- */

function findBrowser() {
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
  throw new Error('Brave/Chrome/Chromium não encontrado. Instale um deles ou defina CHROME_PATH.')
}

export async function launchBrowser() {
  const profile = await mkdtemp(join(tmpdir(), 'cv-chrome-'))
  const proc = spawn(
    findBrowser(),
    [
      '--headless=new',
      '--remote-debugging-port=0',
      `--user-data-dir=${profile}`,
      '--no-first-run',
      '--no-default-browser-check',
      '--disable-extensions',
      '--hide-scrollbars',
      '--disable-crash-reporter',
      '--disable-breakpad',
      // Como root (ex.: dentro de container) o Chrome só sobe sem sandbox
      ...(process.getuid?.() === 0 ? ['--no-sandbox'] : []),
      'about:blank',
    ],
    // detached: o navegador ganha um grupo de processos próprio, para que no fim dê
    // para encerrar também os auxiliares (crash handler, GPU, zygote...)
    { stdio: ['ignore', 'ignore', 'pipe'], detached: true },
  )

  const killGroup = () => {
    try {
      process.kill(-proc.pid, 'SIGKILL')
    } catch {}
  }
  // Se o script morrer no meio (erro, Ctrl+C), não deixa navegador órfão
  process.once('exit', killGroup)

  // O navegador anuncia o endereço do DevTools no stderr
  const wsUrl = await new Promise((ok, fail) => {
    let log = ''
    const timer = setTimeout(() => fail(new Error(`Navegador não respondeu:\n${log}`)), TIMEOUT_MS)
    proc.stderr.on('data', (chunk) => {
      log += chunk
      const match = log.match(/DevTools listening on (ws:\/\/\S+)/)
      if (match) {
        clearTimeout(timer)
        ok(match[1])
      }
    })
    proc.once('exit', (code) => fail(new Error(`Navegador fechou (código ${code}):\n${log}`)))
    proc.once('error', (err) => fail(new Error(`Não foi possível abrir o navegador: ${err.message}`)))
  }).catch(async (err) => {
    await rm(profile, { recursive: true, force: true })
    throw err
  })

  const cdp = await connect(wsUrl)

  /* Encerramento em camadas. Só matar o processo principal não basta: no Brave, processos
     auxiliares herdam o stderr e o mantêm aberto, e o Node fica esperando para sempre. */
  async function close() {
    const exited =
      proc.exitCode !== null || proc.signalCode !== null
        ? Promise.resolve()
        : new Promise((ok) => proc.once('exit', ok))
    try {
      await Promise.race([cdp.send('Browser.close'), sleep(3000)]) // fechamento normal
    } catch {}
    cdp.close()
    await Promise.race([exited, sleep(5000)])
    killGroup() // o que sobrou do grupo
    proc.stderr?.destroy()
    proc.unref()
    process.removeListener('exit', killGroup)
    await rm(profile, { recursive: true, force: true, maxRetries: 3 }).catch(() => {})
  }

  return { cdp, close, openPage: () => openPage(cdp) }
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

/* ---------- Aba ---------- */

async function openPage(cdp) {
  const { targetId } = await cdp.send('Target.createTarget', { url: 'about:blank' })
  const { sessionId } = await cdp.send('Target.attachToTarget', { targetId, flatten: true })
  const send = (method, params) => cdp.send(method, params, sessionId)
  await send('Page.enable')

  return {
    send,

    async goto(url) {
      const loaded = cdp.waitFor('Page.loadEventFired', sessionId)
      const { errorText } = await send('Page.navigate', { url })
      if (errorText) throw new Error(`Não abriu ${url}: ${errorText}`)
      await loaded
    },

    async evaluate(expression) {
      const { result, exceptionDetails } = await send('Runtime.evaluate', {
        expression,
        awaitPromise: true,
        returnByValue: true,
      })
      if (exceptionDetails) throw new Error(exceptionDetails.exception?.description ?? exceptionDetails.text)
      return result.value
    },

    setViewport(width, height) {
      return send('Emulation.setDeviceMetricsOverride', {
        width,
        height,
        deviceScaleFactor: 1,
        mobile: false,
      })
    },

    // Fontes do Google carregadas? (sem elas o PDF sai com fonte Type 3)
    fontsLoaded(family) {
      return this.evaluate(`document.fonts.ready.then(() =>
        [...document.fonts].some((f) => f.family.includes(${JSON.stringify(family)}) && f.status === 'loaded'))`)
    },

    close: () => cdp.send('Target.closeTarget', { targetId }),
  }
}

export const sleep = (ms) => new Promise((ok) => setTimeout(ok, ms))
