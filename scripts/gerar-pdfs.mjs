#!/usr/bin/env node
/**
 * Regera os artefatos estáticos do site a partir do código:
 *   - curriculo-rodrigo-soares.pdf e resume-rodrigo-soares.pdf (igual ao "Salvar como PDF")
 *   - og-image.png (preview ao compartilhar o link), a partir de scripts/og-image.html
 *
 *   node scripts/gerar-pdfs.mjs                      # tudo
 *   node scripts/gerar-pdfs.mjs pt                   # só o PDF em português
 *   node scripts/gerar-pdfs.mjs og                   # só a og-image
 *   node scripts/gerar-pdfs.mjs --permitir-fallback  # gera mesmo sem a IBM Plex
 *   CHROME_PATH=/caminho/do/navegador node scripts/gerar-pdfs.mjs
 *
 * Precisa de internet para carregar a IBM Plex do Google Fonts. Sem ela o script
 * para: a fonte de fallback entra no PDF como Type 3, que parsers de ATS leem mal.
 *
 * Se o conteúdo não mudou, o arquivo não é regravado (o Chrome muda só a data interna
 * do PDF a cada execução) — assim a GitHub Action não commita PDFs idênticos.
 */
import { readFile, writeFile } from 'node:fs/promises'
import { join } from 'node:path'
import { pathToFileURL } from 'node:url'
import { findRoot, launchBrowser } from './lib/navegador.mjs'

const ROOT = findRoot()

const PDFS = {
  pt: 'curriculo-rodrigo-soares.pdf',
  en: 'resume-rodrigo-soares.pdf',
}
const OG = { file: 'og-image.png', template: join(ROOT, 'scripts', 'og-image.html'), width: 1200, height: 630 }

/* ---------- Gravação sem churn ---------- */

// Remove as datas de criação/modificação que o Chrome grava em todo PDF
const semDatas = (buf) =>
  buf.toString('latin1').replace(/\/(CreationDate|ModDate) \(D:[^)]*\)/g, '/$1 ()')

async function gravarSeMudou(name, buf, isPdf) {
  const path = join(ROOT, name)
  try {
    const old = await readFile(path)
    const igual = isPdf ? semDatas(old) === semDatas(buf) : old.equals(buf)
    if (igual) return false
  } catch {}
  await writeFile(path, buf)
  return true
}

function exigirFonte(ok, contexto, allowFallback) {
  if (ok) return
  const msg = `IBM Plex não carregou (${contexto}) — sem internet? A fonte de fallback sai como Type 3.`
  if (!allowFallback) throw new Error(`${msg} Use --permitir-fallback para gerar mesmo assim.`)
  console.warn(`  ⚠ ${msg}`)
}

/* ---------- PDF ---------- */

async function gerarPdf(browser, lang, allowFallback) {
  const page = await browser.openPage()
  try {
    await page.goto(`${pathToFileURL(join(ROOT, 'index.html')).href}?lang=${lang}`)
    exigirFonte(await page.fontsLoaded('IBM Plex Sans'), lang, allowFallback)

    const state = await page.evaluate(`({ lang: document.documentElement.dataset.lang, title: document.title })`)
    if (state.lang !== lang) throw new Error(`Página ficou em "${state.lang}", esperado "${lang}"`)

    // Mesmo caminho do Ctrl+P: o beforeprint encerra as animações de entrada,
    // que bagunçariam a ordem de leitura do PDF
    await page.evaluate(`window.dispatchEvent(new Event('beforeprint')); true`)
    await page.send('Emulation.setEmulatedMedia', { media: 'print' })

    const { data } = await page.send('Page.printToPDF', {
      preferCSSPageSize: true, // usa o @page do style.css (margens)
      paperWidth: 8.27, // A4 em polegadas
      paperHeight: 11.69,
      printBackground: false,
      displayHeaderFooter: false,
      generateTaggedPDF: true, // PDF com estrutura (melhor para leitores de tela e parsers)
    })
    return { buf: Buffer.from(data, 'base64'), title: state.title }
  } finally {
    await page.close()
  }
}

/* ---------- og-image ---------- */

async function gerarOg(browser, allowFallback) {
  const page = await browser.openPage()
  try {
    await page.setViewport(OG.width, OG.height)
    await page.goto(pathToFileURL(OG.template).href)
    exigirFonte(await page.fontsLoaded('IBM Plex Sans'), 'og-image', allowFallback)
    const { data } = await page.send('Page.captureScreenshot', {
      format: 'png',
      clip: { x: 0, y: 0, width: OG.width, height: OG.height, scale: 1 },
    })
    return Buffer.from(data, 'base64')
  } finally {
    await page.close()
  }
}

/* ---------- Principal ---------- */

async function main() {
  const args = process.argv.slice(2)
  const allowFallback = args.includes('--permitir-fallback')
  const valid = [...Object.keys(PDFS), 'og']
  const picked = args.filter((a) => !a.startsWith('--'))
  for (const a of picked) {
    if (!valid.includes(a)) throw new Error(`Opção desconhecida: ${a} (use: ${valid.join(', ')})`)
  }
  const targets = picked.length ? picked : valid

  const browser = await launchBrowser()
  try {
    for (const target of targets) {
      if (target === 'og') {
        const buf = await gerarOg(browser, allowFallback)
        const changed = await gravarSeMudou(OG.file, buf, false)
        console.log(`${changed ? '✓' : '='} ${OG.file}  (${(buf.length / 1024).toFixed(0)} KB${changed ? '' : ' — sem mudanças'})`)
        continue
      }
      const { buf, title } = await gerarPdf(browser, target, allowFallback)
      const changed = await gravarSeMudou(PDFS[target], buf, true)
      console.log(
        `${changed ? '✓' : '='} ${PDFS[target]}  (${(buf.length / 1024).toFixed(0)} KB — ${title}${changed ? '' : ' — sem mudanças'})`,
      )
    }
  } finally {
    await browser.close()
  }
}

main().catch((err) => {
  console.error(`✗ ${err.message}`)
  process.exit(1)
})
