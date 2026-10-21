#!/usr/bin/env node
/**
 * Captura telas dos projetos para a galeria do site e monta img/projetos/manifest.json.
 *
 *   node scripts/capturar-telas.mjs               # captura tudo que está em scripts/telas.json
 *   node scripts/capturar-telas.mjs librishelf    # só um projeto
 *   node scripts/capturar-telas.mjs --manifesto   # não captura; só remonta o manifest
 *   node scripts/capturar-telas.mjs librishelf --cookie="token=..."   # telas que exigem login
 *
 * --cookie: copie o cookie de sessão do seu navegador (DevTools → Application → Cookies).
 * Ele é usado só nesta execução e não é salvo em lugar nenhum — nunca coloque tokens no
 * telas.json, que vai para o repositório e é servido pelo nginx.
 *
 * As URLs ficam em scripts/telas.json. Para projetos sem deploy (Arena, Mercadia), suba o
 * projeto localmente (docker compose up) e aponte para http://localhost:<porta>.
 * Também dá para colocar prints feitos à mão em img/projetos/<projeto>/ (.webp, .png ou .jpg)
 * e rodar com --manifesto. O texto alternativo vem do nome do arquivo ("2-ranking.webp" → "ranking").
 *
 * O site só mostra a galeria de um projeto se ele aparecer no manifest.
 */
import { mkdir, readdir, readFile, writeFile } from 'node:fs/promises'
import { join, extname } from 'node:path'
import { findRoot, launchBrowser, sleep } from './lib/navegador.mjs'

const ROOT = findRoot()
const DIR = join(ROOT, 'img', 'projetos')
const IMAGE = /\.(webp|png|jpe?g)$/i

async function capturar(browser, config, projeto, telas, cookies) {
  await mkdir(join(DIR, projeto), { recursive: true })
  const page = await browser.openPage()
  try {
    await page.setViewport(config.largura, config.altura)
    for (const [i, tela] of telas.entries()) {
      for (const { name, value } of cookies) {
        await page.send('Network.setCookie', { name, value, url: tela.url, secure: tela.url.startsWith('https:') })
      }
      await page.goto(tela.url)
      await sleep(tela.aguardar ?? config.aguardar) // tempo para a SPA buscar dados e animar
      const { data } = await page.send('Page.captureScreenshot', {
        format: 'webp',
        quality: config.qualidade,
        clip: { x: 0, y: 0, width: config.largura, height: config.altura, scale: 1 },
      })
      const file = `${i + 1}-${tela.nome}.webp`
      await writeFile(join(DIR, projeto, file), Buffer.from(data, 'base64'))
      console.log(`✓ img/projetos/${projeto}/${file}  ← ${tela.url}`)
    }
  } finally {
    await page.close()
  }
}

async function montarManifesto() {
  const manifest = {}
  const pastas = await readdir(DIR, { withFileTypes: true }).catch(() => [])
  for (const pasta of pastas.filter((d) => d.isDirectory()).sort((a, b) => a.name.localeCompare(b.name))) {
    const files = (await readdir(join(DIR, pasta.name))).filter((f) => IMAGE.test(f)).sort()
    if (!files.length) continue
    manifest[pasta.name] = files.map((f) => ({
      src: `img/projetos/${pasta.name}/${f}`,
      alt: f.slice(0, -extname(f).length).replace(/^\d+-/, '').replace(/[-_]+/g, ' '),
    }))
  }
  await mkdir(DIR, { recursive: true })
  await writeFile(join(DIR, 'manifest.json'), JSON.stringify(manifest, null, 2) + '\n')
  const total = Object.values(manifest).flat().length
  console.log(`✓ img/projetos/manifest.json  (${Object.keys(manifest).length} projetos, ${total} telas)`)
}

async function main() {
  const args = process.argv.slice(2)
  const cookies = args
    .filter((a) => a.startsWith('--cookie='))
    .map((a) => a.slice('--cookie='.length))
    .filter((c) => c.indexOf('=') > 0)
    .map((c) => ({ name: c.slice(0, c.indexOf('=')), value: c.slice(c.indexOf('=') + 1) }))

  if (!args.includes('--manifesto')) {
    const config = JSON.parse(await readFile(join(ROOT, 'scripts', 'telas.json'), 'utf8'))
    const picked = args.filter((a) => !a.startsWith('--'))
    const projetos = Object.entries(config.projetos).filter(
      ([nome, telas]) => telas.length && (!picked.length || picked.includes(nome)),
    )
    if (!projetos.length) console.warn('  ⚠ Nenhuma tela configurada em scripts/telas.json para capturar.')

    const browser = await launchBrowser()
    try {
      for (const [nome, telas] of projetos) await capturar(browser, config, nome, telas, cookies)
    } finally {
      await browser.close()
    }
  }
  await montarManifesto()
}

main().catch((err) => {
  console.error(`✗ ${err.message}`)
  process.exit(1)
})
