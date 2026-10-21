#!/usr/bin/env bash
# Atualiza o repositório rodrigoacs.com (branch simple) com tudo desta rodada:
# currículo, SEO, selo, galeria, analytics, scripts e GitHub Action.
#
#   cd ~/caminho/rodrigoacs.com
#   bash atualizar-site.sh               # escreve tudo e gera PDFs + og-image
#   bash atualizar-site.sh --sem-gerar   # só escreve os arquivos
#   UMAMI_DIR=~/servicos/umami bash atualizar-site.sh
#
# Não commita nada: no fim, revise com "git status" / "git diff" e commite você mesmo.
set -euo pipefail

GERAR=1
FORCAR=0
for arg in "$@"; do
  case "$arg" in
    --sem-gerar) GERAR=0 ;;
    --forcar) FORCAR=1 ;;
    -h|--help) sed -n '2,11p' "$0"; exit 0 ;;
    *) echo "Opção desconhecida: $arg" >&2; exit 1 ;;
  esac
done

# ---------- Conferências ----------
if [[ ! -f index.html || ! -f style.css || ! -f script.js ]]; then
  echo "✗ Rode na raiz do repositório rodrigoacs.com (onde ficam index.html, style.css e script.js)." >&2
  exit 1
fi

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  BRANCH=$(git branch --show-current)
  if [[ "$BRANCH" != "simple" ]]; then
    echo "⚠ Você está na branch \"$BRANCH\", não na \"simple\"."
    [[ $FORCAR -eq 1 ]] || { echo "  Use --forcar para continuar mesmo assim." >&2; exit 1; }
  fi
  if [[ -n "$(git status --porcelain)" && $FORCAR -eq 0 ]]; then
    echo "✗ Há alterações não commitadas. Commite/guarde (git stash) antes, ou use --forcar." >&2
    git status --short >&2
    exit 1
  fi
fi

UMAMI_DIR="${UMAMI_DIR:-../umami}"

escrever() { # escrever <caminho>  (conteúdo vem do stdin)
  mkdir -p "$(dirname "$1")"
  cat > "$1"
  echo "  ✓ $1"
}

echo "▸ Arquivos do site"
escrever 'index.html' <<'__FIM_ARQUIVO_1__'
<!doctype html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Rodrigo Soares — Desenvolvedor Full Stack</title>
    <meta
      name="description"
      content="Currículo de Rodrigo Soares, desenvolvedor full stack com foco em back-end, integração de sistemas e chatbots com IA. Node.js, PostgreSQL, Vue.js e React Native."
    />
    <meta name="author" content="Rodrigo Soares" />
    <link rel="canonical" id="canonical" href="https://rodrigoacs.com/" />
    <!-- Mesma página em dois idiomas (o inglês é aplicado pelo script.js com ?lang=en) -->
    <link rel="alternate" hreflang="pt-BR" href="https://rodrigoacs.com/" />
    <link rel="alternate" hreflang="en" href="https://rodrigoacs.com/?lang=en" />
    <link rel="alternate" hreflang="x-default" href="https://rodrigoacs.com/" />
    <meta name="theme-color" content="#222222" />
    <link
      rel="icon"
      href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 64 64'%3E%3Crect width='64' height='64' rx='14' fill='%23222222'/%3E%3Crect x='8' y='50' width='8' height='4' fill='%23fc618d'/%3E%3Crect x='16' y='50' width='8' height='4' fill='%23fd9353'/%3E%3Crect x='24' y='50' width='8' height='4' fill='%23fce566'/%3E%3Crect x='32' y='50' width='8' height='4' fill='%237bd88f'/%3E%3Crect x='40' y='50' width='8' height='4' fill='%235ad4e6'/%3E%3Crect x='48' y='50' width='8' height='4' fill='%23948ae3'/%3E%3Ctext x='32' y='41' font-family='monospace' font-size='30' font-weight='700' fill='%23f7f1ff' text-anchor='middle'%3ER%3C/text%3E%3C/svg%3E"
    />

    <!-- Compartilhamento (LinkedIn, WhatsApp, X etc.) -->
    <meta property="og:type" content="profile" />
    <meta property="og:url" content="https://rodrigoacs.com/" />
    <meta property="og:title" content="Rodrigo Soares — Desenvolvedor Full Stack" />
    <meta
      property="og:description"
      content="Back-end, integração de sistemas e chatbots com IA. Node.js · PostgreSQL · Vue.js · React Native."
    />
    <meta property="og:image" content="https://rodrigoacs.com/og-image.png" />
    <meta property="og:image:width" content="1200" />
    <meta property="og:image:height" content="630" />
    <meta property="og:image:alt" content="Rodrigo Soares — Desenvolvedor Full Stack" />
    <meta property="og:locale" content="pt_BR" />
    <meta property="og:locale:alternate" content="en_US" />
    <meta name="twitter:card" content="summary_large_image" />

    <!-- Dados estruturados: ajudam o Google a montar o painel de "Rodrigo Soares desenvolvedor" -->
    <script type="application/ld+json">
      {
        "@context": "https://schema.org",
        "@type": "Person",
        "name": "Rodrigo Soares",
        "jobTitle": "Desenvolvedor Full Stack",
        "url": "https://rodrigoacs.com/",
        "image": "https://rodrigoacs.com/og-image.png",
        "email": "mailto:rodrigohths@gmail.com",
        "telephone": "+55-31-99548-7310",
        "address": {
          "@type": "PostalAddress",
          "addressLocality": "Congonhas",
          "addressRegion": "MG",
          "addressCountry": "BR"
        },
        "sameAs": ["https://github.com/rodrigoacs", "https://www.linkedin.com/in/rodrigoacsoares"],
        "alumniOf": {
          "@type": "CollegeOrUniversity",
          "name": "Instituto Federal de Minas Gerais (IFMG)"
        },
        "knowsLanguage": ["pt-BR", "en"],
        "knowsAbout": [
          "JavaScript",
          "TypeScript",
          "Node.js",
          "Express",
          "Kotlin",
          "Vue.js",
          "React Native",
          "PostgreSQL",
          "MongoDB",
          "Docker",
          "AWS",
          "APIs REST",
          "Microsserviços",
          "ETL",
          "Integração de sistemas",
          "Chatbots com IA"
        ]
      }
    </script>

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;500&family=IBM+Plex+Sans:ital,wght@0,400;0,500;0,600;0,700;1,400&display=swap"
    />
    <link rel="stylesheet" href="style.css" />
    <script>
      ;(function () {
        var root = document.documentElement
        root.classList.add('js')
        try {
          var theme = localStorage.getItem('cv-theme')
          if (theme) root.dataset.theme = theme
          var param = new URLSearchParams(location.search).get('lang')
          if (param === 'en') {
            document.getElementById('canonical').href = 'https://rodrigoacs.com/?lang=en'
          }
          var lang = param || localStorage.getItem('cv-lang')
          if (!lang) lang = /^pt/i.test(navigator.language || '') ? 'pt' : 'en'
          if (lang === 'en') root.classList.add('lang-loading')
          root.dataset.lang = lang
        } catch (e) {}
      })()
    </script>
    <script src="script.js" defer></script>
    <!-- Umami (analytics próprio, sem cookies). Troque o data-website-id pelo ID do site
         criado no painel do Umami. data-domains evita contar visitas locais. -->
    <script
      defer
      src="https://analytics.rodrigoacs.com/stats.js"
      data-website-id="COLE-AQUI-O-WEBSITE-ID"
      data-domains="rodrigoacs.com"
      data-do-not-track="true"
    ></script>
  </head>
  <body>
    <div class="progress" aria-hidden="true"></div>

    <main class="container">
      <header class="cv-header">
        <div>
          <p class="eyebrow">
            <span class="sr-only" data-i18n="role">Desenvolvedor Full Stack</span>
            <span class="typed" aria-hidden="true">Desenvolvedor Full Stack</span>
          </p>
          <h1>Rodrigo Soares</h1>
          <!-- Título profissional: oculto na tela (o selo acima já mostra), visível no PDF para o ATS -->
          <p class="headline" data-i18n="headline">Desenvolvedor Full Stack</p>
          <p class="headline-stack">
            Node.js · TypeScript · Vue.js · React Native · PostgreSQL · Docker · AWS
          </p>
          <!-- URLs escritas por extenso: o ATS lê o texto, não o destino do link -->
          <p class="contact-info">
            <span data-i18n="location">Congonhas - MG, Brasil</span> |
            <a href="tel:+5531995487310" data-i18n="phone" data-umami-event="contato" data-umami-event-canal="telefone">+55 (31) 99548-7310</a><br />
            <a href="mailto:rodrigohths@gmail.com" data-umami-event="contato" data-umami-event-canal="email"
              >rodrigohths@gmail.com</a
            ><span class="sep"> | </span
            ><a href="https://rodrigoacs.com" target="_blank" rel="noopener">rodrigoacs.com</a
            ><span class="sep"> | </span
            ><a
              href="https://github.com/rodrigoacs"
              target="_blank"
              rel="noopener"
              data-umami-event="contato"
              data-umami-event-canal="github"
              >github.com/rodrigoacs</a
            ><span class="sep"> | </span
            ><a
              href="https://www.linkedin.com/in/rodrigoacsoares"
              target="_blank"
              rel="noopener"
              data-umami-event="contato"
              data-umami-event-canal="linkedin"
              >linkedin.com/in/rodrigoacsoares</a
            >
          </p>
          <!-- Só na tela; no PDF, o recrutador já está lendo o currículo -->
          <p class="status">
            <span class="status-dot" aria-hidden="true"></span>
            <span data-i18n="status">Disponível para vagas remotas · PJ ou CLT</span>
          </p>
        </div>

        <div class="actions">
          <button
            type="button"
            class="btn btn-icon btn-lang"
            id="lang-toggle"
            aria-label="EN — Switch to English"
          >
            EN
          </button>
          <button type="button" class="btn btn-icon" id="theme-toggle" aria-label="Alternar tema">
            <svg class="icon-sun" viewBox="0 0 24 24" aria-hidden="true">
              <circle cx="12" cy="12" r="4" />
              <path
                d="M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"
              />
            </svg>
            <svg class="icon-moon" viewBox="0 0 24 24" aria-hidden="true">
              <path d="M21 12.8A9 9 0 1 1 11.2 3a7 7 0 0 0 9.8 9.8z" />
            </svg>
          </button>
          <a
            class="btn btn-primary"
            id="pdf-link"
            href="curriculo-rodrigo-soares.pdf"
            data-umami-event="download-pdf"
            data-umami-event-idioma="pt"
            download="Curriculo - Rodrigo Soares.pdf"
          >
            <svg viewBox="0 0 24 24" aria-hidden="true">
              <path d="M12 3v12M7 10l5 5 5-5M5 21h14" />
            </svg>
            <span data-i18n="download">Currículo em PDF</span>
          </a>
        </div>
      </header>

      <hr />

      <h2 data-i18n="h.summary">Resumo Profissional</h2>
      <p data-i18n="summary">
        Desenvolvedor Full Stack com mais de 3 anos de experiência (incluindo estágio), com foco em
        <strong>back-end</strong> e <strong>integração de sistemas</strong>. Atuo com
        <strong>JavaScript</strong>, <strong>TypeScript</strong>, <strong>Node.js</strong>
        (<strong>Express</strong>), <strong>Kotlin</strong>, <strong>React Native</strong> (Expo),
        <strong>Vue.js</strong>, <strong>PostgreSQL</strong> e <strong>MongoDB</strong> em
        <strong>APIs REST</strong>, <strong>microsserviços</strong>, pipelines ETL e chatbots com IA
        (OpenAI) no WhatsApp. Experiência com <strong>JWT</strong>, <strong>Docker</strong>, <strong>CI/CD</strong>,
        <strong>Nginx</strong>, <strong>Linux</strong>, <strong>Git</strong>/GitHub e
        <strong>AWS</strong> (EC2). Trabalho em equipes de 10 a 15 desenvolvedores com
        <strong>Scrum</strong>, code review e pull requests, aplicando <strong>SOLID</strong> e
        <strong>Clean Code</strong> e <strong>testes automatizados</strong> (Jest).
      </p>

      <hr />

      <h2 data-i18n="h.experience">Experiência Profissional</h2>

      <!-- Preenchido pelo script.js; fica oculto sem JavaScript e no PDF -->
      <div class="filter" id="filter" hidden>
        <span class="filter-label" data-i18n="filter.label">Filtrar por tecnologia</span>
        <div class="filter-chips" id="filter-chips"></div>
        <p class="filter-status" id="filter-status" aria-live="polite"></p>
      </div>

      <div class="job">
        <p class="job-title" data-i18n="scube.title">
          <strong>Desenvolvedor de Software</strong><br />
          <em>S-Cube | 12/2025 - 10/2026 | Remoto</em>
        </p>
        <ul>
          <li data-i18n="scube.1">
            Desenvolvi chatbots de atendimento, vendas e triagem em <strong>JavaScript</strong> (<strong>Node.js</strong> + <strong>Express</strong>), integrando a <strong>API do WhatsApp</strong> (UAZAPI, via webhooks) à <strong>API da OpenAI</strong>, com cerca de 300 mensagens/dia.
          </li>
          <li data-i18n="scube.2">
            Desenvolvi uma API de mensageria <strong>multi-tenant</strong> em Node.js, Express e <strong>PostgreSQL</strong> que centraliza os serviços conectados à UAZAPI, com ambiente em <strong>Docker Compose</strong>.
          </li>
          <li data-i18n="scube.3">
            Implementei a persistência do histórico conversacional em PostgreSQL, autenticação <strong>JWT</strong> e <strong>testes automatizados</strong>; configurei <strong>CI/CD</strong> com deploy automático a cada push (<strong>Docker</strong> + Dokploy).
          </li>
          <li data-i18n="scube.4">
            Desenvolvi um aplicativo mobile em <strong>React Native</strong> (Expo Router + <strong>TypeScript</strong>) para gestão de associados e eventos de um cliente e reduzi o tamanho do APK de ~109 MB para ~62 MB (−43%).
          </li>
          <li data-i18n="scube.5">
            Atuei em equipe de 10 a 15 desenvolvedores com <strong>Scrum</strong> (sprints no Jira/ClickUp), <strong>code review</strong> e versionamento com <strong>Git</strong>/GitHub.
          </li>
        </ul>
        <ul class="tags">
          <li><button type="button" class="tag" data-tech="node">Node.js</button></li>
          <li><button type="button" class="tag" data-tech="express">Express</button></li>
          <li><button type="button" class="tag" data-tech="postgres">PostgreSQL</button></li>
          <li><button type="button" class="tag" data-tech="openai">OpenAI</button></li>
          <li><button type="button" class="tag" data-tech="whatsapp">WhatsApp API</button></li>
          <li><button type="button" class="tag" data-tech="jwt">JWT</button></li>
          <li><button type="button" class="tag" data-tech="docker">Docker</button></li>
          <li><button type="button" class="tag" data-tech="react-native">React Native</button></li>
          <li><button type="button" class="tag" data-tech="ts">TypeScript</button></li>
        </ul>
      </div>
      <div class="job">
        <p class="job-title" data-i18n="b2list.title">
          <strong>Desenvolvedor de Software</strong><br />
          <em>B2List | 09/2024 - 12/2025 | Remoto</em>
        </p>
        <ul>
          <li data-i18n="b2list.1">
            Construí e mantive 8 a 10 <strong>microsserviços</strong> e pipelines de dados (<strong>ETL</strong>) em <strong>JavaScript</strong> (<strong>Node.js</strong>) e <strong>Kotlin</strong>, processando cerca de 600 mil registros.
          </li>
          <li data-i18n="b2list.2">
            Desenvolvi <strong>APIs</strong> em Node.js para as regras de negócio da plataforma, com foco em performance e manutenibilidade.
          </li>
          <li data-i18n="b2list.3">
            Atuei em equipe de 10 a 15 desenvolvedores com <strong>Scrum</strong>, <strong>pull requests</strong> e <strong>code review</strong> (<strong>Git</strong>).
          </li>
        </ul>
        <ul class="tags">
          <li><button type="button" class="tag" data-tech="node">Node.js</button></li>
          <li><button type="button" class="tag" data-tech="kotlin">Kotlin</button></li>
          <li><button type="button" class="tag" data-tech="etl">ETL</button></li>
          <li><button type="button" class="tag" data-tech="rest">REST</button></li>
        </ul>
      </div>
      <div class="job">
        <p class="job-title" data-i18n="cli2.title">
          <strong>Analista de Desenvolvimento de Sistemas</strong><br />
          <em>CLI Consultoria | 03/2024 - 07/2024 | Remoto</em>
        </p>
        <ul>
          <li data-i18n="cli2.1">
            Reduzi o tempo de uma integração de dados de mais de 10 horas para cerca de 15 minutos.
          </li>
          <li data-i18n="cli2.2">
            Otimizei <strong>APIs RESTful</strong> de consumo de dados em tempo real em sistemas críticos, com foco em baixa latência e disponibilidade.
          </li>
          <li data-i18n="cli2.3">
            Desenvolvi <strong>middlewares</strong> de orquestração e transformação de dados entre <strong>SAP</strong> e <strong>Salesforce</strong>, evoluindo código legado.
          </li>
          <li data-i18n="cli2.4">
            Contribuí para a arquitetura e a escalabilidade das aplicações em sprints (<strong>Scrum</strong>); promovido de estagiário a analista.
          </li>
        </ul>
        <ul class="tags">
          <li><button type="button" class="tag" data-tech="rest">REST</button></li>
          <li><button type="button" class="tag" data-tech="sap">SAP</button></li>
          <li><button type="button" class="tag" data-tech="salesforce">Salesforce</button></li>
          <li><button type="button" class="tag" data-tech="etl">ETL</button></li>
        </ul>
      </div>
      <div class="job">
        <p class="job-title" data-i18n="cli1.title">
          <strong>Estagiário de Desenvolvimento</strong><br />
          <em>CLI Consultoria | 02/2023 - 03/2024 | Remoto</em>
        </p>
        <ul>
          <li data-i18n="cli1.1">
            Desenvolvi rotinas de ingestão de dados a partir de APIs, banco de dados <strong>MongoDB</strong>, ERPs (SAP, Winthor) e CRM (Salesforce).
          </li>
          <li data-i18n="cli1.2">
            Mantive e otimizei pipelines de dados existentes, incluindo código legado, melhorando performance e confiabilidade.
          </li>
          <li data-i18n="cli1.3">
            Administrei servidores <strong>Linux</strong> em ambiente cloud <strong>AWS</strong> (EC2), seguindo práticas DevOps.
          </li>
        </ul>
        <ul class="tags">
          <li><button type="button" class="tag" data-tech="etl">ETL</button></li>
          <li><button type="button" class="tag" data-tech="sap">SAP</button></li>
          <li><button type="button" class="tag" data-tech="winthor">Winthor</button></li>
          <li><button type="button" class="tag" data-tech="salesforce">Salesforce</button></li>
          <li><button type="button" class="tag" data-tech="mongodb">MongoDB</button></li>
          <li><button type="button" class="tag" data-tech="aws">AWS EC2</button></li>
          <li><button type="button" class="tag" data-tech="linux">Linux</button></li>
        </ul>
      </div>

      <hr />

      <h2 data-i18n="h.projects">Projetos Pessoais</h2>
      <div class="job" data-projeto="arena">
        <p class="job-title">
          <strong data-i18n="arena.title"
            >Arena — Gerenciador de Ligas e Torneios de Magic: The Gathering</strong
          >
          <span class="job-links">
            <a href="https://github.com/rodrigoacs/arena" target="_blank" rel="noopener"
              >github.com/rodrigoacs/arena</a
            >
          </span><br />
          <em data-i18n="arena.date">Projeto pessoal | 10/2025 - Atual</em>
        </p>
        <ul>
          <li data-i18n="arena.1">
            Gerenciador de ligas e torneios de Magic: The Gathering com <strong>Vue 3</strong>,
            PrimeVue e Tailwind no front-end e API em <strong>Express 5</strong> +
            <strong>PostgreSQL</strong>, com autenticação JWT, emparelhamento de rodadas, ranking
            com critérios de desempate e página pública da liga. Ambiente containerizado com Docker
            e Nginx.
          </li>
        </ul>
        <ul class="tags">
          <li><button type="button" class="tag" data-tech="vue">Vue.js</button></li>
          <li><button type="button" class="tag" data-tech="primevue">PrimeVue</button></li>
          <li><button type="button" class="tag" data-tech="tailwind">Tailwind</button></li>
          <li><button type="button" class="tag" data-tech="node">Node.js</button></li>
          <li><button type="button" class="tag" data-tech="express">Express</button></li>
          <li><button type="button" class="tag" data-tech="postgres">PostgreSQL</button></li>
          <li><button type="button" class="tag" data-tech="jwt">JWT</button></li>
          <li><button type="button" class="tag" data-tech="docker">Docker</button></li>
        </ul>
      </div>
      <div class="job" data-projeto="mercadia">
        <p class="job-title">
          <strong>Mercadia</strong>
          <span class="job-links">
            <a href="https://github.com/rodrigoacs/mercadia" target="_blank" rel="noopener"
              >github.com/rodrigoacs/mercadia</a
            >
          </span><br />
          <em data-i18n="mercadia.date">Projeto pessoal | 12/2025 - Atual</em>
        </p>
        <ul>
          <li data-i18n="mercadia.1">
            Terminal financeiro e gestor de coleções e decks de Magic: The Gathering. Back-end em
            <strong>Node.js/Express</strong> + <strong>PostgreSQL</strong> que sincroniza os dados
            em massa da API da Scryfall via streaming e coleta preços da LigaMagic com web scraping
            (Cheerio), protegido com JWT, Helmet e rate limiting. Front-end em JavaScript puro,
            instalável como <strong>PWA</strong>, com gráficos em Chart.js. Containerizado com
            Docker.
          </li>
        </ul>
        <ul class="tags">
          <li><button type="button" class="tag" data-tech="node">Node.js</button></li>
          <li><button type="button" class="tag" data-tech="express">Express</button></li>
          <li><button type="button" class="tag" data-tech="postgres">PostgreSQL</button></li>
          <li><button type="button" class="tag" data-tech="cheerio">Web scraping</button></li>
          <li><button type="button" class="tag" data-tech="chartjs">Chart.js</button></li>
          <li><button type="button" class="tag" data-tech="pwa">PWA</button></li>
          <li><button type="button" class="tag" data-tech="docker">Docker</button></li>
          <li><button type="button" class="tag" data-tech="rest">REST</button></li>
        </ul>
      </div>
      <div class="job" data-projeto="librishelf">
        <p class="job-title">
          <strong>Librishelf</strong>
          <span class="job-links">
            <a class="live" href="https://librishelf.com" target="_blank" rel="noopener"
              >librishelf.com</a
            >
            <a href="https://github.com/rodrigoacs/librishelf" target="_blank" rel="noopener"
              >github.com/rodrigoacs/librishelf</a
            >
          </span><br />
          <em data-i18n="librishelf.date">Projeto pessoal | 06/2024 - Atual</em>
        </p>
        <ul>
          <li data-i18n="librishelf.1">
            Biblioteca pessoal para catalogar e acompanhar coleções de livros. Front-end
            <strong>responsivo</strong> em <strong>Vue 3</strong>, PrimeVue, vue-i18n (português e
            inglês) e Chart.js consumindo a <strong>API REST</strong> em <strong>Express 5</strong> +
            <strong>PostgreSQL</strong>, com migrations próprias, autenticação JWT em cookie httpOnly,
            processamento de capas com sharp, e-mails transacionais (Nodemailer) e
            <strong>testes de integração</strong> com <strong>Jest</strong> e Supertest. Deploy com
            Docker Compose e Nginx.
          </li>
        </ul>
        <ul class="tags">
          <li><button type="button" class="tag" data-tech="vue">Vue.js</button></li>
          <li><button type="button" class="tag" data-tech="primevue">PrimeVue</button></li>
          <li><button type="button" class="tag" data-tech="chartjs">Chart.js</button></li>
          <li><button type="button" class="tag" data-tech="node">Node.js</button></li>
          <li><button type="button" class="tag" data-tech="express">Express</button></li>
          <li><button type="button" class="tag" data-tech="postgres">PostgreSQL</button></li>
          <li><button type="button" class="tag" data-tech="jest">Jest</button></li>
          <li><button type="button" class="tag" data-tech="nginx">Nginx</button></li>
          <li><button type="button" class="tag" data-tech="docker">Docker</button></li>
        </ul>
      </div>

      <hr />

      <h2 data-i18n="h.education">Formação Acadêmica</h2>
      <div class="education">
        <p data-i18n="edu.1">
          <strong>Bacharelado em Sistemas de Informação</strong><br />
          IFMG, Ouro Branco - MG | 09/2021 - 07/2027 (previsão de conclusão)
        </p>
      </div>
      <div class="education">
        <p data-i18n="edu.2">
          <strong>Técnico Integrado em Mecânica</strong><br />
          IFMG, Congonhas - MG | 01/2018 - 04/2021
        </p>
      </div>

      <hr />

      <h2 data-i18n="h.skills">Tecnologias e Competências</h2>
      <ul>
        <li data-i18n="skills.1">
          <strong>Linguagens:</strong> JavaScript, TypeScript, Kotlin, SQL, Java, Python.
        </li>
        <li data-i18n="skills.2">
          <strong>Back-end:</strong> Node.js, Express, APIs REST (RESTful), autenticação JWT, microsserviços, webhooks, ETL, integração de sistemas (SAP, Winthor, Salesforce), Design Patterns.
        </li>
        <li data-i18n="skills.3">
          <strong>Front-end:</strong> Vue.js (Vue 3), HTML5, CSS3, Tailwind CSS, PrimeVue, Bootstrap, Chart.js, PWA.
        </li>
        <li data-i18n="skills.4">
          <strong>Mobile:</strong> React Native (Expo, Expo Router).
        </li>
        <li data-i18n="skills.5">
          <strong>Banco de Dados:</strong> PostgreSQL, MySQL, Oracle, MongoDB.
        </li>
        <li data-i18n="skills.6">
          <strong>DevOps &amp; Cloud:</strong> Docker, Docker Compose, Dokploy, Nginx, Git, GitHub, GitHub Actions, CI/CD, AWS (EC2), Linux.
        </li>
        <li data-i18n="skills.7">
          <strong>Qualidade:</strong> SOLID, Clean Code, code review, pull requests, testes automatizados (Jest, Supertest).
        </li>
        <li data-i18n="skills.8">
          <strong>Metodologias:</strong> Scrum (sprints), Jira, ClickUp.
        </li>
        <li data-i18n="skills.9">
          <strong>IA &amp; Mensageria:</strong> OpenAI API, WhatsApp (UAZAPI), chatbots, webhooks, mensageria multi-tenant.
        </li>
      </ul>

      <hr />

      <h2 data-i18n="h.languages">Idiomas</h2>
      <ul class="languages">
        <li data-i18n="lang.1">
          <strong>Inglês:</strong> intermediário (conversação); leitura técnica avançada.
        </li>
        <li data-i18n="lang.2"><strong>Português:</strong> nativo.</li>
      </ul>

      <footer class="cv-footer">
        <p>
          <button type="button" class="terminal-hint" id="terminal-open">
            <span aria-hidden="true">❯_</span>
            <span data-i18n="footer.terminal">abrir o terminal</span>
            <kbd>Ctrl</kbd><kbd>K</kbd>
          </button>
          <span class="footer-note" data-i18n="footer.note"
            >Feito à mão com HTML, CSS e JavaScript</span
          >
        </p>
      </footer>
    </main>

    <dialog class="terminal" id="terminal" aria-label="Terminal">
      <div class="terminal-bar">
        <span class="terminal-dots" aria-hidden="true"><i></i><i></i><i></i></span>
        <span class="terminal-title">rodrigo@rodrigoacs: ~</span>
        <button type="button" class="terminal-close" id="terminal-close" aria-label="Fechar">
          ×
        </button>
      </div>
      <div class="terminal-body" id="terminal-body">
        <div class="terminal-output" id="terminal-output" aria-live="polite"></div>
        <form class="terminal-line" id="terminal-form" autocomplete="off">
          <label for="terminal-input" class="prompt">❯</label>
          <input id="terminal-input" type="text" spellcheck="false" autocapitalize="off" />
        </form>
      </div>
    </dialog>
  </body>
</html>
__FIM_ARQUIVO_1__

escrever 'style.css' <<'__FIM_ARQUIVO_2__'
/* Fontes carregadas no <head> do index.html (mais rápido que @import) */

/* ---------- Tokens: Monokai Pro (Filter Spectrum) ----------
   Escuro = cores originais do Filter Spectrum.
   Claro  = mesmas matizes, escurecidas para manter contraste AA em fundo claro. */
:root {
  --bg: #f3eff8;
  --paper: #fdfbff;
  --text: #222222;
  --muted: #625f66;
  --line: #e4dfea;
  --shadow: 0 1px 2px rgba(34, 34, 34, 0.04), 0 12px 40px -12px rgba(34, 34, 34, 0.14);

  --red: #c8255a;
  --orange: #b34d0f;
  --yellow: #8a6a00;
  --green: #2b7f3f;
  --blue: #0b7285;
  --purple: #5f4fc4;
  --on-accent: #ffffff;

  --accent: var(--red);

  --font-sans: "IBM Plex Sans", system-ui, -apple-system, "Segoe UI", sans-serif;
  --font-mono: "IBM Plex Mono", ui-monospace, "SFMono-Regular", monospace;
  --ease: cubic-bezier(0.22, 1, 0.36, 1);

  color-scheme: light;
}

@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) {
    --bg: #191919;
    --paper: #222222;
    --text: #f7f1ff;
    --muted: #8b888f;
    --line: #363537;
    --shadow: 0 1px 2px rgba(0, 0, 0, 0.35), 0 16px 48px -16px rgba(0, 0, 0, 0.7);

    --red: #fc618d;
    --orange: #fd9353;
    --yellow: #fce566;
    --green: #7bd88f;
    --blue: #5ad4e6;
    --purple: #948ae3;
    --on-accent: #191919;

    color-scheme: dark;
  }
}

:root[data-theme="dark"] {
  --bg: #191919;
  --paper: #222222;
  --text: #f7f1ff;
  --muted: #8b888f;
  --line: #363537;
  --shadow: 0 1px 2px rgba(0, 0, 0, 0.35), 0 16px 48px -16px rgba(0, 0, 0, 0.7);

  --red: #fc618d;
  --orange: #fd9353;
  --yellow: #fce566;
  --green: #7bd88f;
  --blue: #5ad4e6;
  --purple: #948ae3;
  --on-accent: #191919;

  color-scheme: dark;
}

/* Recalculado em cada elemento, então acompanha a cor da seção */
* {
  --accent-soft: color-mix(in srgb, var(--accent) 11%, transparent);
}

/* ---------- Uma cor do espectro por seção ----------
   Cada h2 pinta a si mesmo e tudo que vem depois dele;
   o h2 seguinte sobrescreve. Não precisa de JS. */
.container>h2:nth-of-type(1),
.container>h2:nth-of-type(1)~* {
  --accent: var(--green);
}

.container>h2:nth-of-type(2),
.container>h2:nth-of-type(2)~* {
  --accent: var(--red);
}

.container>h2:nth-of-type(3),
.container>h2:nth-of-type(3)~* {
  --accent: var(--orange);
}

.container>h2:nth-of-type(4),
.container>h2:nth-of-type(4)~* {
  --accent: var(--blue);
}

.container>h2:nth-of-type(5),
.container>h2:nth-of-type(5)~* {
  --accent: var(--purple);
}

.container>h2:nth-of-type(6),
.container>h2:nth-of-type(6)~* {
  --accent: var(--yellow);
}

.container>hr {
  --accent: var(--line);
}

/* ---------- Base ---------- */
*,
*::before,
*::after {
  box-sizing: border-box;
}

html {
  -webkit-text-size-adjust: 100%;
  scroll-behavior: smooth;
}

body {
  margin: 0;
  padding: 64px 16px;
  min-height: 100vh;
  background:
    radial-gradient(800px 460px at 10% -10%, color-mix(in srgb, var(--purple) 12%, transparent), transparent 70%),
    radial-gradient(700px 420px at 100% 0%, color-mix(in srgb, var(--red) 10%, transparent), transparent 70%),
    var(--bg);
  background-attachment: fixed;
  color: var(--text);
  font: 400 16px/1.65 var(--font-sans);
  -webkit-font-smoothing: antialiased;
  transition:
    background-color 0.3s ease,
    color 0.3s ease;
}

::selection {
  background: var(--accent);
  color: var(--on-accent);
}

.container {
  max-width: 800px;
  margin: 0 auto;
  padding: 56px 64px;
  background: var(--paper);
  border: 1px solid var(--line);
  border-radius: 16px;
  box-shadow: var(--shadow);
  transition:
    background-color 0.3s ease,
    border-color 0.3s ease;
}

/* Faixa do espectro no topo do cartão */
.container {
  position: relative;
  overflow: hidden;
}

.container::before {
  content: "";
  position: absolute;
  inset: 0 0 auto 0;
  height: 4px;
  background: linear-gradient(90deg,
      var(--red) 0 16.66%,
      var(--orange) 0 33.33%,
      var(--yellow) 0 50%,
      var(--green) 0 66.66%,
      var(--blue) 0 83.33%,
      var(--purple) 0);
}

p {
  margin: 0 0 12px;
}

strong {
  font-weight: 600;
}

a {
  color: var(--accent);
  text-decoration: none;
  background: linear-gradient(currentColor, currentColor) no-repeat 0 100% / 0 1px;
  transition: background-size 0.3s var(--ease);
}

a:hover {
  background-size: 100% 1px;
}

a:focus-visible,
.btn:focus-visible {
  outline: 2px solid var(--accent);
  outline-offset: 3px;
  border-radius: 4px;
}

hr {
  margin: 40px 0;
  border: 0;
  border-top: 1px solid var(--line);
}

/* ---------- Barra de progresso ---------- */
.progress {
  position: fixed;
  inset: 0 0 auto 0;
  z-index: 10;
  height: 3px;
  background: linear-gradient(90deg,
      var(--red),
      var(--orange),
      var(--yellow),
      var(--green),
      var(--blue),
      var(--purple));
  transform: scaleX(var(--progress, 0));
  transform-origin: left;
  pointer-events: none;
}

/* ---------- Cabeçalho ---------- */
/* Grid em vez de flex: os botões ficam na coluna da direita e a linha de
   contatos pode ocupar a largura inteira, embaixo deles. O div da esquerda
   vira "transparente" (display: contents) para os filhos entrarem no grid. */
.cv-header {
  display: grid;
  grid-template-columns: 1fr auto;
  align-items: start;
  column-gap: 24px;
}

.cv-header > div:first-child {
  display: contents;
}

.cv-header > div:first-child > * {
  grid-column: 1;
  justify-self: start;
}

.cv-header .actions {
  grid-column: 2;
  grid-row: 1;
}

.cv-header > div:first-child > h1,
.cv-header > div:first-child > .contact-info,
.cv-header > div:first-child > .headline,
.cv-header > div:first-child > .headline-stack,
.cv-header > div:first-child > .status {
  grid-column: 1 / -1;
}

.eyebrow {
  --accent: var(--green);
  display: inline-flex;
  align-items: center;
  gap: 8px;
  margin: 0 0 14px;
  padding: 4px 10px;
  border-radius: 999px;
  background: var(--accent-soft);
  color: var(--accent);
  font-family: var(--font-mono);
  font-size: 0.72rem;
  font-weight: 500;
  letter-spacing: 0.08em;
  text-transform: uppercase;
}

.eyebrow::before {
  content: "";
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: currentColor;
  animation: pulse 2.4s ease-in-out infinite;
}

@keyframes pulse {

  0%,
  100% {
    opacity: 1;
  }

  50% {
    opacity: 0.35;
  }
}

h1 {
  margin: 0 0 12px;
  font-size: 2.2rem;
  font-weight: 700;
  line-height: 1.12;
  letter-spacing: -0.025em;
}

.contact-info {
  margin: 0;
  color: var(--muted);
  font-size: 0.875rem;
}

.contact-info strong {
  font-weight: 500;
}

.contact-info a {
  white-space: nowrap;
}

/* ---------- Botões ---------- */
.actions {
  display: flex;
  gap: 8px;
  flex-shrink: 0;
}

.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  height: 40px;
  padding: 0 16px;
  border: 1px solid var(--line);
  border-radius: 10px;
  background: var(--paper);
  color: var(--text);
  font: 500 0.9rem/1 var(--font-sans);
  cursor: pointer;
  transition:
    transform 0.2s var(--ease),
    box-shadow 0.2s var(--ease),
    border-color 0.2s ease,
    background-color 0.2s ease;
}

a.btn {
  text-decoration: none;
}

.btn svg {
  width: 18px;
  height: 18px;
  fill: none;
  stroke: currentColor;
  stroke-width: 2;
  stroke-linecap: round;
  stroke-linejoin: round;
}

.btn:hover {
  transform: translateY(-1px);
  border-color: var(--accent);
}

.btn:active {
  transform: translateY(0);
}

.btn-primary {
  border-color: var(--accent);
  background: var(--accent);
  color: var(--on-accent);
}

.btn-primary:hover {
  box-shadow: 0 8px 20px -8px var(--accent);
}

.btn-primary:hover svg {
  animation: nudge 0.6s var(--ease);
}

@keyframes nudge {
  50% {
    transform: translateY(2px);
  }
}

.btn-icon {
  width: 40px;
  padding: 0;
}

.btn-icon svg {
  transition: transform 0.4s var(--ease);
}

.btn-icon:hover svg {
  transform: rotate(20deg);
}

/* Mostra o sol no escuro (para ir ao claro) e a lua no claro */
.icon-sun {
  display: none;
}

:root[data-theme="dark"] .icon-sun {
  display: block;
}

:root[data-theme="dark"] .icon-moon {
  display: none;
}

@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) .icon-sun {
    display: block;
  }

  :root:not([data-theme="light"]) .icon-moon {
    display: none;
  }
}

/* ---------- Títulos de seção ---------- */
h2 {
  display: flex;
  align-items: center;
  gap: 12px;
  margin: 0 0 24px;
  color: var(--accent);
  font-family: var(--font-mono);
  font-size: 0.78rem;
  font-weight: 500;
  letter-spacing: 0.14em;
  text-transform: uppercase;
}

h2::before {
  content: "";
  width: 20px;
  border-top: 2px solid currentColor;
  /* borda (não background) para aparecer na impressão */
  transition: width 0.6s var(--ease) 0.15s;
}

/* ---------- Experiências e projetos ---------- */
.job {
  position: relative;
  margin: 0 -16px 12px;
  padding: 14px 16px 14px 36px;
  border-radius: 12px;
  transition: background-color 0.25s ease;
}

/* Linha da timeline */
.job::before {
  content: "";
  position: absolute;
  top: 0;
  bottom: -12px;
  left: 16px;
  border-left: 2px solid var(--line);
  /* borda para aparecer na impressão */
}

.job:not(:has(+ .job))::before {
  bottom: 14px;
}

/* Marcador da timeline */
.job::after {
  content: "";
  position: absolute;
  top: 22px;
  left: 12px;
  width: 10px;
  height: 10px;
  border: 2px solid var(--line);
  border-radius: 50%;
  background: var(--paper);
  transition:
    border-color 0.25s ease,
    background-color 0.25s ease,
    transform 0.25s var(--ease);
}

.job:hover {
  background: var(--accent-soft);
}

.job:hover::after {
  border-color: var(--accent);
  background: var(--accent);
  transform: scale(1.15);
}

.job-title {
  margin-bottom: 8px;
  line-height: 1.45;
}

.job-title strong {
  font-size: 1.05rem;
}

.job-title em {
  color: var(--muted);
  font-family: var(--font-mono);
  font-size: 0.8rem;
  font-style: normal;
}

ul {
  margin: 0;
  padding-left: 1.1em;
}

li {
  margin-bottom: 6px;
}

li::marker {
  color: var(--accent);
}

/* ---------- Formação ---------- */
.education {
  margin-bottom: 16px;
}

.education:last-of-type {
  margin-bottom: 0;
}

.education p {
  margin: 0;
  color: var(--muted);
}

.education strong {
  color: var(--text);
}

/* ---------- Competências (lista direta do container) ---------- */
.container>ul {
  padding: 0;
  list-style: none;
}

.container>ul li {
  display: grid;
  grid-template-columns: 190px 1fr;
  gap: 16px;
  margin: 0 -12px;
  padding: 10px 12px;
  border-bottom: 1px dashed var(--line);
  border-radius: 8px;
  font-size: 0.95rem;
  transition: background-color 0.2s ease;
}

.container>ul li:hover {
  background: var(--accent-soft);
}

.container>ul li:last-child {
  border-bottom: 0;
}

.container>ul li strong {
  font-weight: 500;
}

/* Contatos: na tela, cada link quebra inteiro e sem "|" sobrando no fim da linha;
   no PDF os separadores voltam (ver @media print) */
.contact-info a {
  display: inline-block;
  margin-right: 12px;
}

.contact-info a:last-child {
  margin-right: 0;
}

.contact-info .sep {
  display: none;
}

/* ---------- Selo de disponibilidade ---------- */
.status {
  --accent: var(--green);
  display: inline-flex;
  align-items: center;
  gap: 10px;
  margin: 16px 0 0;
  padding: 5px 14px 5px 11px;
  border: 1px solid color-mix(in srgb, var(--accent) 40%, transparent);
  border-radius: 999px;
  background: var(--accent-soft);
  color: var(--text);
  font-size: 0.85rem;
}

.status-dot {
  flex-shrink: 0;
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: var(--accent);
  box-shadow: 0 0 0 3px color-mix(in srgb, var(--accent) 25%, transparent);
}

/* ---------- Galeria de telas dos projetos ---------- */
.shots {
  margin: 10px 0 4px;
}

.shots summary {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  color: var(--accent);
  font-family: var(--font-mono);
  font-size: 0.78rem;
  letter-spacing: 0.04em;
  cursor: pointer;
  list-style: none;
}

.shots summary::-webkit-details-marker {
  display: none;
}

.shots summary::before {
  content: "▸";
  transition: transform 0.2s var(--ease);
}

.shots[open] summary::before {
  transform: rotate(90deg);
}

.shots-strip {
  display: flex;
  gap: 12px;
  overflow-x: auto;
  padding: 12px 2px 6px;
  scroll-snap-type: x mandatory;
}

.shots-strip a {
  flex: 0 0 min(340px, 85%);
  overflow: hidden;
  border: 1px solid var(--line);
  border-radius: 10px;
  scroll-snap-align: start;
  transition: border-color 0.2s ease, transform 0.2s var(--ease);
}

.shots-strip a:hover {
  border-color: var(--accent);
  transform: translateY(-2px);
}

.shots-strip img {
  display: block;
  width: 100%;
  height: auto;
  aspect-ratio: 16 / 10;
  object-fit: cover;
  object-position: top;
}

/* Título profissional: só aparece no PDF (na tela, o selo .eyebrow faz esse papel) */
.headline,
.headline-stack {
  display: none;
}

/* ---------- Utilitários ---------- */
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  margin: -1px;
  overflow: hidden;
  clip: rect(0 0 0 0);
  white-space: nowrap;
  border: 0;
}

/* Evita "piscar" o português antes de trocar para inglês */
.lang-loading .container {
  visibility: hidden;
}

kbd {
  display: inline-block;
  min-width: 1.6em;
  padding: 1px 6px;
  border: 1px solid var(--line);
  border-bottom-width: 2px;
  border-radius: 5px;
  background: var(--bg);
  color: var(--text);
  font: 500 0.72rem/1.4 var(--font-mono);
  text-align: center;
}

/* ---------- Selo com digitação ---------- */
.typed {
  min-height: 1em;
}

.typed::after {
  content: "";
  display: inline-block;
  width: 0.55em;
  height: 1em;
  margin-left: 2px;
  vertical-align: -0.15em;
  background: currentColor;
  animation: blink 1s steps(1) infinite;
}

@keyframes blink {
  50% {
    opacity: 0;
  }
}

/* ---------- Botão de idioma ---------- */
.btn-lang {
  font-family: var(--font-mono);
  font-size: 0.78rem;
  letter-spacing: 0.04em;
}

/* ---------- Links dos projetos ---------- */
.job-links {
  display: flex;
  flex-wrap: wrap;
  gap: 4px 14px;
  margin-top: 4px;
  font-family: var(--font-mono);
  font-size: 0.78rem;
}

.job-links a::after {
  content: " ↗";
}

.job-links .live {
  display: inline-flex;
  align-items: center;
  gap: 6px;
}

.job-links .live::before {
  content: "";
  width: 7px;
  height: 7px;
  border-radius: 50%;
  background: var(--green);
  box-shadow: 0 0 0 3px color-mix(in srgb, var(--green) 25%, transparent);
  animation: pulse 2.4s ease-in-out infinite;
}

/* ---------- Tags de tecnologia ---------- */
.job ul.tags {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
  margin: 10px 0 0;
  padding: 0;
  list-style: none;
}

.job ul.tags li {
  margin: 0;
}

.tag,
.chip {
  padding: 3px 9px;
  border: 1px solid color-mix(in srgb, var(--accent) 35%, transparent);
  border-radius: 999px;
  background: var(--accent-soft);
  color: var(--accent);
  font: 500 0.72rem/1.4 var(--font-mono);
  cursor: pointer;
  transition:
    background-color 0.2s ease,
    color 0.2s ease,
    border-color 0.2s ease,
    transform 0.2s var(--ease);
}

.tag:hover,
.chip:hover {
  border-color: var(--accent);
  transform: translateY(-1px);
}

.tag.is-active,
.chip[aria-pressed="true"] {
  border-color: var(--accent);
  background: var(--accent);
  color: var(--on-accent);
}

.tag:focus-visible,
.chip:focus-visible,
.terminal-hint:focus-visible {
  outline: 2px solid var(--accent);
  outline-offset: 2px;
}

/* ---------- Filtro ---------- */
.filter {
  margin: -6px 0 22px;
  padding: 14px 16px;
  border: 1px dashed var(--line);
  border-radius: 12px;
}

.filter[hidden] {
  display: none;
}

.filter-label {
  display: block;
  margin-bottom: 8px;
  color: var(--muted);
  font: 500 0.72rem/1 var(--font-mono);
  letter-spacing: 0.08em;
  text-transform: uppercase;
}

.filter-chips {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.filter-status {
  margin: 10px 0 0;
  color: var(--muted);
  font-size: 0.82rem;
}

/* Itens fora do filtro saem da página (e seções vazias também) */
.is-hidden {
  display: none !important;
}

/* Último item visível de cada seção fecha a linha da timeline */
.job.is-last::before {
  bottom: 14px;
}

.job.is-entering {
  animation: job-in 0.45s var(--ease) both;
}

@keyframes job-in {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
}

.filter-empty {
  margin: 0 0 20px;
  padding: 12px 16px;
  border-radius: 10px;
  background: var(--accent-soft);
  color: var(--muted);
  font-size: 0.9rem;
}

.filter-empty[hidden] {
  display: none;
}

/* ---------- Rodapé ---------- */
.cv-footer {
  margin-top: 40px;
  padding-top: 20px;
  border-top: 1px solid var(--line);
}

.cv-footer p {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
  margin: 0;
  color: var(--muted);
  font-size: 0.82rem;
}

.terminal-hint {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 6px 10px;
  border: 1px solid var(--line);
  border-radius: 8px;
  background: none;
  color: var(--text);
  font: 500 0.8rem/1 var(--font-mono);
  cursor: pointer;
  transition: border-color 0.2s ease;
}

.terminal-hint:hover {
  border-color: var(--accent);
}

.terminal-hint>span:first-child {
  color: var(--accent);
}

/* Atalho de teclado não faz sentido em tela de toque */
@media (hover: none) {
  .terminal-hint kbd {
    display: none;
  }
}

/* ---------- Terminal ---------- */
.terminal {
  width: min(680px, calc(100vw - 32px));
  max-height: min(480px, calc(100vh - 64px));
  padding: 0;
  border: 1px solid #363537;
  border-radius: 12px;
  background: #222222;
  color: #f7f1ff;
  box-shadow: 0 30px 80px -20px rgba(0, 0, 0, 0.6);
  overflow: hidden;
}

.terminal[open] {
  display: flex;
  flex-direction: column;
  animation: term-in 0.25s var(--ease);
}

@keyframes term-in {
  from {
    opacity: 0;
    transform: translateY(12px) scale(0.98);
  }
}

.terminal::backdrop {
  background: rgba(10, 10, 10, 0.55);
  backdrop-filter: blur(3px);
}

.terminal-bar {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 10px 14px;
  border-bottom: 1px solid #363537;
  background: #191919;
}

.terminal-dots {
  display: flex;
  gap: 6px;
}

.terminal-dots i {
  width: 11px;
  height: 11px;
  border-radius: 50%;
  background: #fc618d;
}

.terminal-dots i:nth-child(2) {
  background: #fce566;
}

.terminal-dots i:nth-child(3) {
  background: #7bd88f;
}

.terminal-title {
  flex: 1;
  color: #8b888f;
  font: 0.78rem var(--font-mono);
  text-align: center;
}

.terminal-close {
  border: 0;
  background: none;
  color: #8b888f;
  font-size: 1.3rem;
  line-height: 1;
  cursor: pointer;
}

.terminal-close:hover {
  color: #f7f1ff;
}

.terminal-body {
  flex: 1;
  padding: 14px 16px;
  overflow-y: auto;
  font: 0.85rem/1.6 var(--font-mono);
}

.t-line {
  white-space: pre-wrap;
  word-break: break-word;
}

.t-cmd {
  color: #f7f1ff;
}

.t-accent {
  color: #7bd88f;
}

.t-muted {
  color: #8b888f;
}

.t-error {
  color: #fc618d;
}

.t-line a {
  color: #5ad4e6;
}

.terminal-line {
  display: flex;
  gap: 8px;
  margin-top: 4px;
}

.prompt {
  color: #fc618d;
}

.terminal-line input {
  flex: 1;
  min-width: 0;
  border: 0;
  outline: none;
  background: none;
  color: #f7f1ff;
  font: inherit;
  caret-color: #fce566;
}

/* ---------- Animação de entrada (ativada pelo script.js) ---------- */
.js .reveal {
  opacity: 0;
  transform: translateY(14px);
  transition:
    opacity 0.7s var(--ease) var(--delay, 0ms),
    transform 0.7s var(--ease) var(--delay, 0ms);
}

.js .reveal.is-visible {
  opacity: 1;
  transform: none;
}

.js h2.reveal:not(.is-visible)::before {
  width: 0;
}

@media (prefers-reduced-motion: reduce) {

  *,
  *::before,
  *::after {
    animation: none !important;
    transition: none !important;
  }

  html {
    scroll-behavior: auto;
  }
}

/* ---------- Mobile ---------- */
@media (max-width: 640px) {
  body {
    padding: 0;
    background: var(--paper);
  }

  .container {
    padding: 32px 16px 40px;
    border: 0;
    border-radius: 0;
    box-shadow: none;
  }

  .cv-header {
    grid-template-columns: 1fr;
  }

  .cv-header .actions {
    grid-column: 1;
    grid-row: 1;
    width: 100%;
    margin-bottom: 20px;
  }

  .btn-primary {
    flex: 1;
  }

  h1 {
    font-size: 1.75rem;
  }

  hr {
    margin: 32px 0;
  }

  .job {
    margin: 0 -8px 8px;
    padding: 12px 8px 12px 30px;
  }

  .job::before {
    left: 12px;
  }

  .job::after {
    left: 8px;
  }

  .container>ul li {
    grid-template-columns: 1fr;
    gap: 2px;
  }
}

/* ---------- Impressão / Salvar como PDF ---------- */
@media print {
  @page {
    margin: 12mm 15mm;
  }

  /* PDF simples: preto no branco, uma fonte só, sem enfeites */
  *,
  *::before,
  *::after {
    --text: #000;
    --muted: #000;
    --accent: #000;
    --accent-soft: transparent;
    --line: #000;
    color: #000 !important;
    background: none !important;
    box-shadow: none !important;
    animation: none !important;
    transition: none !important;
  }

  :root,
  :root:not([data-theme="light"]),
  :root[data-theme="dark"] {
    color-scheme: light;
  }

  html,
  body {
    background: #fff !important;
  }

  .filter,
  .status,
  .shots,
  .job ul.tags,
  .cv-footer,
  .terminal,
  .job-links a::after,
  .job-links .live::before,
  .progress,
  .actions,
  .eyebrow,
  .container::before,
  .job::before,
  .job::after,
  h2::before {
    display: none !important;
  }

  body {
    padding: 0;
    font: 10.5pt/1.45 var(--font-sans);
  }

  .container {
    max-width: none;
    padding: 0;
    border: 0;
    border-radius: 0;
    overflow: visible;
  }

  /* O PDF sempre sai completo, mesmo com filtro ativo na tela */
  h2.is-hidden,
  .job.is-hidden {
    display: block !important;
  }

  .filter-empty {
    display: none !important;
  }

  .js .reveal,
  .job.is-entering {
    animation: none !important;
    opacity: 1 !important;
    transform: none !important;
    filter: none !important;
  }

  .job-links {
    display: inline;
    margin: 0 0 0 6px;
    font: 10pt var(--font-sans);
  }

  .job-links a+a::before {
    content: " · ";
  }

  h1 {
    margin-bottom: 4px;
    font-size: 18pt;
    letter-spacing: 0;
  }

  .contact-info {
    font-size: 10pt;
  }

  hr {
    display: none;
  }

  h2 {
    display: block;
    margin: 13px 0 7px;
    padding-bottom: 2px;
    border-bottom: 1px solid #000;
    font-family: var(--font-sans);
    font-size: 11pt;
    font-weight: 700;
    letter-spacing: 0.04em;
    break-after: avoid;
  }

  /* position: static — elementos posicionados são pintados depois do fluxo
     normal, e o PDF herda essa ordem: o parser do ATS lia títulos, formação e
     competências antes das experiências que caíam na página 2 */
  .container,
  .job {
    position: static !important;
  }

  /* Um emprego pode continuar na página seguinte (evita meia página em branco),
     mas o título nunca fica sozinho no pé da página e nenhum bullet é partido */
  .job {
    margin: 0 0 8px;
    padding: 0;
    border-radius: 0;
  }

  .job-title {
    break-inside: avoid;
    break-after: avoid;
  }

  .job li {
    break-inside: avoid;
  }

  .contact-info a {
    display: inline;
    margin-right: 0;
  }

  .contact-info .sep {
    display: inline;
  }

  .headline {
    display: block;
    margin: 0;
    font-size: 11pt;
    font-weight: 600;
  }

  /* Tecnologias numa linha própria: o parser grava só o cargo como título */
  .headline-stack {
    display: block;
    margin: 0 0 4px;
    font-size: 10pt;
  }

  .job-title {
    margin-bottom: 2px;
  }

  .job-title strong {
    font-size: 10.5pt;
  }

  /* Sem itálico: quando a IBM Plex itálica não carrega, o Chrome embute uma
     fonte Type 3 de fallback, que alguns parsers de ATS leem mal */
  .job-title em {
    font-family: var(--font-sans);
    font-size: 10pt;
    font-style: normal;
  }

  li {
    margin-bottom: 2px;
  }

  li::marker {
    color: #000;
  }

  .education {
    margin-bottom: 6px;
    break-inside: avoid;
  }

  /* Competências como linhas simples "Categoria: itens" */
  .container>ul li {
    display: block;
    margin: 0;
    padding: 1px 0;
    border: 0;
    border-radius: 0;
    font-size: 10.5pt;
  }

  .container>ul li strong {
    font-weight: 700;
  }

  a {
    text-decoration: none;
  }
}
__FIM_ARQUIVO_2__

escrever 'script.js' <<'__FIM_ARQUIVO_3__'
/* Tudo dentro de uma função: nada vaza para o escopo global (window). */
(() => {
  const root = document.documentElement
  const $ = (sel, ctx = document) => ctx.querySelector(sel)
  const $$ = (sel, ctx = document) => [...ctx.querySelectorAll(sel)]
  const reduceMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches

  function store(key, value) {
    try {
      localStorage.setItem(key, value)
    } catch (e) { }
  }

  /* Evento no Umami, se o script dele carregou (bloqueadores de anúncio podem impedir) */
  function track(name, data) {
    try {
      window.umami?.track(name, data)
    } catch (e) { }
  }

  /* =========================================================
     Textos (PT vem do próprio HTML; EN fica aqui)
     ========================================================= */
  const UI = {
    pt: {
      title: "Rodrigo Soares — Desenvolvedor Full Stack",
      langBtn: "EN",
      langLabel: "EN — Switch to English",
      themeLabel: "Alternar tema",
      tagsLabel: "Tecnologias",
      roles: ["Desenvolvedor Full Stack", "Back-end Node.js", "Integrações e IA"],
      filterAll: "Todas",
      filterStatus: (n, total, tech) => `Mostrando ${n} de ${total} itens com ${tech}`,
      filterHint: "Clique numa tecnologia para ver só o que usa ela",
      filterEmpty: (tech) => `Nenhuma experiência profissional com ${tech} — veja os projetos abaixo.`,
      shots: (n) => `Ver telas (${n})`,
    },
    en: {
      title: "Rodrigo Soares — Full Stack Developer",
      langBtn: "PT",
      langLabel: "PT — Mudar para português",
      themeLabel: "Toggle theme",
      tagsLabel: "Technologies",
      roles: ["Full Stack Developer", "Node.js Back-end", "Integrations & AI"],
      filterAll: "All",
      filterStatus: (n, total, tech) => `Showing ${n} of ${total} entries with ${tech}`,
      filterHint: "Click a technology to show only what uses it",
      filterEmpty: (tech) => `No professional experience with ${tech} — see the projects below.`,
      shots: (n) => `View screenshots (${n})`,
    },
  }

  const EN = {
    role: "Full Stack Developer",
    location: "Congonhas - MG, Brazil",
    phone: "+55 (31) 99548-7310",
    status: "Open to remote roles · contractor or full-time",
    website: "Website",
    download: "Resume (PDF)",
    "h.summary": "Professional Summary",
    "h.experience": "Professional Experience",
    "h.projects": "Personal Projects",
    "h.education": "Education",
    "h.skills": "Skills &amp; Technologies",
    "h.languages": "Languages",
    "filter.label": "Filter by technology",
    headline: "Full Stack Developer",
    summary: `Full Stack Developer with 3+ years of experience (including an internship), focused on
    <strong>back-end</strong> and <strong>systems integration</strong>. I work with
    <strong>JavaScript</strong>, <strong>TypeScript</strong>, <strong>Node.js</strong>
    (<strong>Express</strong>), <strong>Kotlin</strong>, <strong>React Native</strong> (Expo),
    <strong>Vue.js</strong>, <strong>PostgreSQL</strong> and <strong>MongoDB</strong> on
    <strong>REST APIs</strong>, <strong>microservices</strong>, ETL pipelines and AI chatbots (OpenAI)
    on WhatsApp. Experienced with <strong>JWT</strong>, <strong>Docker</strong>, <strong>CI/CD</strong>, <strong>Nginx</strong>,
    <strong>Linux</strong>, <strong>Git</strong>/GitHub and <strong>AWS</strong> (EC2). I work in teams
    of 10 to 15 developers using <strong>Scrum</strong>, code review and pull requests, applying
    <strong>SOLID</strong>, <strong>Clean Code</strong> and <strong>automated testing</strong>
    (Jest).`,
    "scube.title": `<strong>Software Developer</strong><br />
    <em>S-Cube | 12/2025 - 10/2026 | Remote</em>`,
    "scube.1": `Built support, sales and triage chatbots in <strong>JavaScript</strong>
    (<strong>Node.js</strong> + <strong>Express</strong>), integrating the <strong>WhatsApp API</strong> (UAZAPI, via webhooks)
    with the <strong>OpenAI API</strong>, handling about 300 messages/day.`,
    "scube.2": `Built a <strong>multi-tenant</strong> messaging API in Node.js, Express and
    <strong>PostgreSQL</strong> that centralizes the services connected to UAZAPI, running on
    <strong>Docker Compose</strong>.`,
    "scube.3": `Implemented conversation history persistence in PostgreSQL, <strong>JWT</strong>
    authentication and <strong>automated tests</strong>; set up <strong>CI/CD</strong> with automatic
    deployment on every push (<strong>Docker</strong> + Dokploy).`,
    "scube.4": `Developed a <strong>React Native</strong> mobile app (Expo Router +
    <strong>TypeScript</strong>) for a client's member and event management and reduced the APK size
    from ~109 MB to ~62 MB (−43%).`,
    "scube.5": `Worked in a team of 10 to 15 developers using <strong>Scrum</strong> (sprints in
    Jira/ClickUp), <strong>code review</strong> and version control with <strong>Git</strong>/GitHub.`,
    "b2list.title": `<strong>Software Developer</strong><br />
    <em>B2List | 09/2024 - 12/2025 | Remote</em>`,
    "b2list.1": `Built and maintained 8 to 10 <strong>microservices</strong> and data pipelines
    (<strong>ETL</strong>) in <strong>JavaScript</strong> (<strong>Node.js</strong>) and <strong>Kotlin</strong>, processing about
    600,000 records.`,
    "b2list.2": `Developed <strong>APIs</strong> in Node.js for the platform's business rules,
    focusing on performance and maintainability.`,
    "b2list.3": `Worked in a team of 10 to 15 developers using <strong>Scrum</strong>,
    <strong>pull requests</strong> and <strong>code review</strong> (<strong>Git</strong>).`,
    "cli2.title": `<strong>Systems Development Analyst</strong><br />
    <em>CLI Consultoria | 03/2024 - 07/2024 | Remote</em>`,
    "cli2.1": `Reduced the runtime of a data integration from over 10 hours to about 15 minutes.`,
    "cli2.2": `Optimized <strong>RESTful APIs</strong> for real-time data consumption in critical
    systems, focusing on low latency and availability.`,
    "cli2.3": `Developed <strong>middleware</strong> to orchestrate and transform data between
    <strong>SAP</strong> and <strong>Salesforce</strong>, evolving legacy code.`,
    "cli2.4": `Contributed to application architecture and scalability in sprints
    (<strong>Scrum</strong>); promoted from intern to analyst.`,
    "cli1.title": `<strong>Software Development Intern</strong><br />
    <em>CLI Consultoria | 02/2023 - 03/2024 | Remote</em>`,
    "cli1.1": `Built data ingestion routines from APIs, <strong>MongoDB</strong> databases, ERPs
    (SAP, Winthor) and CRM (Salesforce).`,
    "cli1.2": `Maintained and optimized existing data pipelines, including legacy code, improving
    performance and reliability.`,
    "cli1.3": `Administered <strong>Linux</strong> servers in an <strong>AWS</strong> (EC2) cloud
    environment, following DevOps practices.`,
    "arena.date": `Personal project | 10/2025 - Present`,
    "mercadia.date": `Personal project | 12/2025 - Present`,
    "librishelf.date": `Personal project | 06/2024 - Present`,
    "arena.title": "Arena — Magic: The Gathering League and Tournament Manager",
    "arena.1": `League and tournament manager for Magic: The Gathering with <strong>Vue 3</strong>,
    PrimeVue and Tailwind on the front-end and an <strong>Express 5</strong> +
    <strong>PostgreSQL</strong> API, featuring JWT authentication, round pairings, rankings with
    tiebreakers and a public league page. Containerized with Docker and Nginx.`,
    "mercadia.1": `Financial terminal and collection/deck manager for Magic: The Gathering. A
    <strong>Node.js/Express</strong> + <strong>PostgreSQL</strong> back-end streams Scryfall's bulk
    data and collects LigaMagic prices through web scraping (Cheerio), secured with JWT, Helmet and
    rate limiting. Vanilla JavaScript front-end, installable as a <strong>PWA</strong>, with
    Chart.js charts. Containerized with Docker.`,
    "librishelf.1": `Personal library to catalog and track book collections. A
    <strong>responsive</strong> <strong>Vue 3</strong> front-end with PrimeVue, vue-i18n (Portuguese
    and English) and Chart.js consumes a <strong>REST API</strong> built with <strong>Express 5</strong>
    + <strong>PostgreSQL</strong>, with custom migrations, JWT authentication in httpOnly cookies,
    cover processing with sharp, transactional emails (Nodemailer) and <strong>integration
    tests</strong> with <strong>Jest</strong> and Supertest. Deployed with Docker Compose and Nginx.`,
    "edu.1": `<strong>Bachelor's Degree in Information Systems</strong><br />
    IFMG, Ouro Branco - MG, Brazil | 09/2021 - 07/2027 (expected)`,
    "edu.2": `<strong>Technical Diploma in Mechanics (integrated with high school)</strong><br />
    IFMG, Congonhas - MG, Brazil | 01/2018 - 04/2021`,
    "skills.1": "<strong>Programming Languages:</strong> JavaScript, TypeScript, Kotlin, SQL, Java, Python.",
    "skills.2": "<strong>Back-end:</strong> Node.js, Express, REST (RESTful) APIs, JWT authentication, microservices, webhooks, ETL, systems integration (SAP, Winthor, Salesforce), Design Patterns.",
    "skills.3": "<strong>Front-end:</strong> Vue.js (Vue 3), HTML5, CSS3, Tailwind CSS, PrimeVue, Bootstrap, Chart.js, PWA.",
    "skills.4": "<strong>Mobile:</strong> React Native (Expo, Expo Router).",
    "skills.5": "<strong>Databases:</strong> PostgreSQL, MySQL, Oracle, MongoDB.",
    "skills.6": "<strong>DevOps &amp; Cloud:</strong> Docker, Docker Compose, Dokploy, Nginx, Git, GitHub, GitHub Actions, CI/CD, AWS (EC2), Linux.",
    "skills.7": "<strong>Quality:</strong> SOLID, Clean Code, code review, pull requests, automated testing (Jest, Supertest).",
    "skills.8": "<strong>Methodologies:</strong> Scrum (sprints), Jira, ClickUp.",
    "skills.9": "<strong>AI &amp; Messaging:</strong> OpenAI API, WhatsApp (UAZAPI), chatbots, webhooks, multi-tenant messaging.",
    "lang.1": "<strong>English:</strong> intermediate (conversational); advanced technical reading.",
    "lang.2": "<strong>Portuguese:</strong> native.",
    "footer.terminal": "open the terminal",
    "footer.note": "Hand-made with HTML, CSS and JavaScript",
  }

  /* PT original, lido do HTML antes de qualquer troca */
  const PT = {}
  $$("[data-i18n]").forEach((el) => (PT[el.dataset.i18n] = el.innerHTML))

  let lang = root.dataset.lang === "en" ? "en" : "pt"
  const t = () => UI[lang]

  function applyLang(next, save = false) {
    lang = next
    const dict = lang === "en" ? EN : PT
    $$("[data-i18n]").forEach((el) => {
      const value = dict[el.dataset.i18n]
      if (value !== undefined) el.innerHTML = value
    })

    root.lang = lang === "en" ? "en" : "pt-BR"
    root.dataset.lang = lang
    document.title = t().title

    const langBtn = $("#lang-toggle")
    if (langBtn) {
      langBtn.textContent = t().langBtn
      langBtn.setAttribute("aria-label", t().langLabel)
    }
    $("#theme-toggle")?.setAttribute("aria-label", t().themeLabel)

    // PDF estático no idioma da página
    const pdf = $("#pdf-link")
    if (pdf) {
      pdf.href = lang === "en" ? "resume-rodrigo-soares.pdf" : "curriculo-rodrigo-soares.pdf"
      pdf.setAttribute("download", lang === "en" ? "Resume - Rodrigo Soares.pdf" : "Curriculo - Rodrigo Soares.pdf")
      pdf.dataset.umamiEventIdioma = lang
    }
    updateShotLabels()
    $$(".tags").forEach((ul) => ul.setAttribute("aria-label", t().tagsLabel))

    if (save) {
      store("cv-lang", lang)
      const url = new URL(location.href)
      url.searchParams.delete("lang")
      history.replaceState(null, "", url)
    }

    renderFilter()
    restartTyping()
    root.classList.remove("lang-loading")
  }

  $("#lang-toggle")?.addEventListener("click", () => applyLang(lang === "en" ? "pt" : "en", true))

  /* =========================================================
     Tema e PDF
     ========================================================= */
  const prefersDark = window.matchMedia("(prefers-color-scheme: dark)")
  const currentTheme = () => root.dataset.theme || (prefersDark.matches ? "dark" : "light")

  function toggleTheme() {
    const next = currentTheme() === "dark" ? "light" : "dark"
    root.dataset.theme = next
    store("cv-theme", next)
    return next
  }

  $("#theme-toggle")?.addEventListener("click", toggleTheme)

  /* Na impressão, tira a animação de entrada inteira (não só a deixa visível):
     uma transição de opacity/transform ainda em andamento cria um stacking
     context, o Chrome pinta esses blocos fora da ordem do documento e o PDF
     herda essa ordem — o ATS chegava a ler o resumo depois das experiências. */
  let printRevealed = []
  window.addEventListener("beforeprint", () => {
    // Encerra na hora as transições/animações em andamento (inclusive a barra de progresso)
    document.getAnimations?.().forEach((a) => {
      try {
        a.finish()
      } catch (e) {
        a.cancel()
      }
    })
    printRevealed = $$(".reveal")
    printRevealed.forEach((el) => el.classList.remove("reveal", "is-entering"))
  })
  window.addEventListener("afterprint", () => {
    printRevealed.forEach((el) => el.classList.add("reveal", "is-visible"))
    printRevealed = []
  })


  /* =========================================================
     Selo com efeito de digitação
     ========================================================= */
  const typed = $(".typed")
  let typingTimer

  function restartTyping() {
    clearTimeout(typingTimer)
    if (!typed) return
    const roles = t().roles
    if (reduceMotion) {
      typed.textContent = roles[0]
      return
    }

    let roleIndex = 0
    let charIndex = roles[0].length
    let deleting = false
    typed.textContent = roles[0]

    const tick = () => {
      const word = roles[roleIndex]
      if (!deleting && charIndex === word.length) {
        deleting = true
        typingTimer = setTimeout(tick, 2200)
        return
      }
      if (deleting && charIndex === 0) {
        deleting = false
        roleIndex = (roleIndex + 1) % roles.length
        typingTimer = setTimeout(tick, 350)
        return
      }
      charIndex += deleting ? -1 : 1
      typed.textContent = roles[roleIndex].slice(0, charIndex)
      typingTimer = setTimeout(tick, deleting ? 35 : 70)
    }

    typingTimer = setTimeout(tick, 2200)
  }

  /* =========================================================
     Filtro por tecnologia
     ========================================================= */
  const TECH = {
    node: "Node.js",
    express: "Express",
    postgres: "PostgreSQL",
    vue: "Vue.js",
    "react-native": "React Native",
    ts: "TypeScript",
    docker: "Docker",
    openai: "OpenAI",
    whatsapp: "WhatsApp API",
    etl: "ETL",
    rest: "REST",
    sql: "SQL",
    sap: "SAP",
    salesforce: "Salesforce",
    winthor: "Winthor",
    mongodb: "MongoDB",
    aws: "AWS EC2",
    linux: "Linux",
    primevue: "PrimeVue",
    tailwind: "Tailwind",
    jwt: "JWT",
    chartjs: "Chart.js",
    cheerio: "Web scraping",
    pwa: "PWA",
    jest: "Jest",
    nginx: "Nginx",
    kotlin: "Kotlin",
  }
  const FEATURED = ["node", "postgres", "docker", "vue", "react-native", "openai", "sap", "etl"]

  const jobs = $$(".job")
  const jobTechs = new Map(jobs.map((job) => [job, new Set($$(".tag", job).map((b) => b.dataset.tech))]))
  /* Agrupa cada item pelo título de seção (h2) que vem antes dele */
  const sections = new Map()
  jobs.forEach((job) => {
    let el = job.previousElementSibling
    while (el && el.tagName !== "H2") el = el.previousElementSibling
    if (!el) return
    if (!sections.has(el)) sections.set(el, [])
    sections.get(el).push(job)
  })

  /* Aviso para quando nenhuma experiência usa a tecnologia escolhida */
  const emptyNote = document.createElement("p")
  emptyNote.className = "filter-empty"
  emptyNote.hidden = true
  $("#filter")?.after(emptyNote)

  let activeTech = new URLSearchParams(location.search).get("tech")
  if (activeTech && !TECH[activeTech]) activeTech = null

  function renderFilter() {
    const box = $("#filter")
    const chips = $("#filter-chips")
    const status = $("#filter-status")
    if (!box || !chips) return
    box.hidden = false

    const list = [...FEATURED]
    if (activeTech && !list.includes(activeTech)) list.push(activeTech)

    chips.replaceChildren(
      ...[null, ...list].map((tech) => {
        const b = document.createElement("button")
        b.type = "button"
        b.className = "chip"
        b.textContent = tech ? TECH[tech] : t().filterAll
        b.setAttribute("aria-pressed", String(activeTech === tech))
        b.addEventListener("click", () => setFilter(tech === activeTech ? null : tech))
        return b
      })
    )

    let matches = 0
    jobs.forEach((job) => {
      const match = !activeTech || jobTechs.get(job).has(activeTech)
      if (match) matches++
      const wasHidden = job.classList.contains("is-hidden")
      job.classList.toggle("is-hidden", !match)
      job.classList.remove("is-last")
      // Animação curta para quem reaparece
      if (match && wasHidden && !reduceMotion) {
        job.classList.remove("is-entering")
        void job.offsetWidth
        job.classList.add("is-entering")
      }
    })

    // Seções: esconde as que ficaram vazias (menos a que contém o filtro)
    sections.forEach((items, heading) => {
      const visible = items.filter((job) => !job.classList.contains("is-hidden"))
      visible.at(-1)?.classList.add("is-last") // fecha a linha da timeline no último visível
      const holdsFilter = heading.nextElementSibling?.id === "filter"
      if (holdsFilter) {
        emptyNote.hidden = visible.length > 0
        emptyNote.textContent = activeTech ? t().filterEmpty(TECH[activeTech]) : ""
      } else {
        const empty = visible.length === 0
        heading.classList.toggle("is-hidden", empty)
        const hr = heading.previousElementSibling
        if (hr?.tagName === "HR") hr.classList.toggle("is-hidden", empty)
      }
    })
    $$(".tag").forEach((tag) => {
      const on = tag.dataset.tech === activeTech
      tag.classList.toggle("is-active", on)
      tag.setAttribute("aria-pressed", String(on))
    })

    status.textContent = activeTech
      ? t().filterStatus(matches, jobs.length, TECH[activeTech])
      : t().filterHint
  }

  function setFilter(tech) {
    activeTech = tech
    if (tech) track("filtro", { tecnologia: tech })
    const url = new URL(location.href)
    if (tech) url.searchParams.set("tech", tech)
    else url.searchParams.delete("tech")
    history.replaceState(null, "", url)
    renderFilter()
  }

  $$(".tag").forEach((tag) =>
    tag.addEventListener("click", () => {
      const tech = tag.dataset.tech
      setFilter(tech === activeTech ? null : tech)
      if (activeTech) $("#filter")?.scrollIntoView({ behavior: reduceMotion ? "auto" : "smooth", block: "start" })
    })
  )

  /* =========================================================
     Mini terminal (Ctrl+K ou `)
     ========================================================= */
  const term = $("#terminal")
  const output = $("#terminal-output")
  const input = $("#terminal-input")
  const history_ = []
  let historyIndex = -1

  function termPrint(text = "", cls) {
    const line = document.createElement("div")
    line.className = "t-line" + (cls ? ` t-${cls}` : "")
    line.textContent = text
    output.append(line)
    return line
  }

  function printLink(label, href) {
    const line = termPrint("")
    const a = document.createElement("a")
    a.href = href
    a.target = "_blank"
    a.rel = "noopener"
    a.textContent = label
    line.append(a)
  }

  const jobsIn = (key) =>
    [...sections].find(([heading]) => heading.dataset.i18n === key)?.[1] ?? []

  const sectionText = (selector) =>
    $$(selector).map((el) => el.innerText.replace(/\s+/g, " ").trim())

  const COMMANDS = {
    help() {
      const pt = lang === "pt"
      termPrint(pt ? "Comandos disponíveis:" : "Available commands:", "accent");
      [
        ["whoami", pt ? "quem sou eu" : "who I am"],
        ["experience", pt ? "experiência profissional" : "work experience"],
        ["projects", pt ? "projetos pessoais" : "personal projects"],
        ["skills", pt ? "tecnologias" : "tech stack"],
        ["contact", pt ? "como falar comigo" : "how to reach me"],
        ["filter <tech>", pt ? "filtra o currículo (ex.: filter docker)" : "filter the CV (e.g. filter docker)"],
        ["theme", pt ? "alterna claro/escuro" : "toggle light/dark"],
        ["lang", pt ? "alterna PT/EN" : "toggle PT/EN"],
        ["pdf", pt ? "baixa o currículo em PDF" : "download the resume as PDF"],
        ["clear", pt ? "limpa a tela" : "clear the screen"],
        ["exit", pt ? "fecha o terminal" : "close the terminal"],
      ].forEach(([cmd, desc]) => termPrint(`  ${cmd.padEnd(15)} ${desc}`))
    },
    whoami() {
      termPrint("Rodrigo Soares", "accent")
      termPrint(t().roles.join(" · "))
      termPrint(lang === "pt" ? "Congonhas - MG, Brasil" : "Congonhas - MG, Brazil", "muted")
    },
    experience() {
      jobsIn("h.experience").forEach((job) => {
        const [title, meta] = $(".job-title", job).innerText.split("\n")
        termPrint(`▸ ${title}`, "accent")
        termPrint(`  ${meta}`, "muted")
      })
    },
    projects() {
      jobsIn("h.projects").forEach((job) => {
        termPrint(`▸ ${$(".job-title strong", job).innerText}`, "accent")
        $$(".job-links a", job).forEach((a) => printLink(`  ${a.textContent}`, a.href))
      })
    },
    skills() {
      sectionText(".container > ul:not(.languages) li").forEach((line) => termPrint(`• ${line}`))
    },
    contact() {
      printLink("  +55 (31) 99548-7310", "tel:+5531995487310")
      printLink("  rodrigohths@gmail.com", "mailto:rodrigohths@gmail.com")
      printLink("  github.com/rodrigoacs", "https://github.com/rodrigoacs")
      printLink("  linkedin.com/in/rodrigoacsoares", "https://www.linkedin.com/in/rodrigoacsoares")
    },
    filter(arg) {
      if (!arg) {
        setFilter(null)
        termPrint(lang === "pt" ? "Filtro removido." : "Filter cleared.", "muted")
        return
      }
      const key = Object.keys(TECH).find(
        (k) => k === arg || TECH[k].toLowerCase().replace(/\W/g, "") === arg.replace(/\W/g, "")
      )
      if (!key) {
        termPrint(`${lang === "pt" ? "Tecnologia desconhecida" : "Unknown technology"}: ${arg}`, "error")
        termPrint(Object.keys(TECH).join(", "), "muted")
        return
      }
      setFilter(key)
      termPrint(t().filterStatus(...countMatches(key), TECH[key]))
    },
    theme() {
      termPrint(`theme → ${toggleTheme()}`, "muted")
    },
    lang() {
      applyLang(lang === "en" ? "pt" : "en", true)
      termPrint(`lang → ${lang}`, "muted")
    },
    pdf() {
      term.close()
      $("#pdf-link")?.click()
    },
    clear() {
      output.replaceChildren()
    },
    exit() {
      term.close()
    },
    sudo(arg) {
      if (arg === "hire-me" || arg === "contratar") {
        termPrint(lang === "pt" ? "Permissão concedida. ✔" : "Permission granted. ✔", "accent")
        printLink("  +55 (31) 99548-7310", "tel:+5531995487310")
        printLink("  rodrigohths@gmail.com", "mailto:rodrigohths@gmail.com")
      } else {
        termPrint(lang === "pt" ? "Boa tentativa. Experimente: sudo hire-me" : "Nice try. Try: sudo hire-me", "error")
      }
    },
  }
  COMMANDS.ls = COMMANDS.help
  COMMANDS.about = COMMANDS.whoami
  COMMANDS.sobre = COMMANDS.whoami
  COMMANDS.experiencia = COMMANDS.experience
  COMMANDS.projetos = COMMANDS.projects
  COMMANDS.contato = COMMANDS.contact
  COMMANDS.tema = COMMANDS.theme

  function countMatches(tech) {
    const n = jobs.filter((job) => jobTechs.get(job).has(tech)).length
    return [n, jobs.length]
  }

  function run(raw) {
    const line = raw.trim()
    termPrint(`❯ ${line}`, "cmd")
    if (!line) return
    history_.unshift(line)
    historyIndex = -1
    const [name, ...rest] = line.split(/\s+/)
    const cmd = COMMANDS[name.toLowerCase()]
    if (cmd) cmd(rest.join(" ").toLowerCase())
    else
      termPrint(
        lang === "pt"
          ? `comando não encontrado: ${name}. Digite "help".`
          : `command not found: ${name}. Type "help".`,
        "error"
      )
  }

  function openTerminal() {
    if (!term || term.open) return
    if (!output.childElementCount) {
      termPrint(lang === "pt" ? "Bem-vindo! Digite \"help\" para ver os comandos." : 'Welcome! Type "help" to see the commands.', "muted")
    }
    term.showModal()
    input.focus()
    track("terminal")
  }

  $("#terminal-open")?.addEventListener("click", openTerminal)
  $("#terminal-close")?.addEventListener("click", () => term.close())
  term?.addEventListener("click", (e) => {
    if (e.target === term) term.close() // clique fora da janela
  })

  $("#terminal-form")?.addEventListener("submit", (e) => {
    e.preventDefault()
    run(input.value)
    input.value = ""
    const body = $("#terminal-body")
    body.scrollTop = body.scrollHeight
  })

  input?.addEventListener("keydown", (e) => {
    if (e.key === "ArrowUp" || e.key === "ArrowDown") {
      e.preventDefault()
      historyIndex = Math.max(-1, Math.min(history_.length - 1, historyIndex + (e.key === "ArrowUp" ? 1 : -1)))
      input.value = historyIndex >= 0 ? history_[historyIndex] : ""
    } else if (e.key === "Tab") {
      e.preventDefault()
      const found = Object.keys(COMMANDS).filter((c) => c.startsWith(input.value.toLowerCase()))
      if (found.length === 1) input.value = found[0] + " "
    }
  })

  document.addEventListener("keydown", (e) => {
    const typing = /^(INPUT|TEXTAREA|SELECT)$/.test(document.activeElement?.tagName)
    if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === "k") {
      e.preventDefault()
      term?.open ? term.close() : openTerminal()
    } else if (e.key === "`" && !typing) {
      e.preventDefault()
      openTerminal()
    } else if (e.key === "Escape" && activeTech && !term?.open) {
      setFilter(null)
    }
  })

  /* =========================================================
     Animação de entrada ao rolar
     ========================================================= */
  const targets = $$(".cv-header, .container > p, h2, .filter, .job, .education, .container > ul li, .cv-footer")

  targets.forEach((el, i) => {
    el.classList.add("reveal")
    el.style.setProperty("--delay", `${(i % 4) * 60}ms`)
  })

  if (reduceMotion || !("IntersectionObserver" in window)) {
    targets.forEach((el) => el.classList.add("is-visible"))
  } else {
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add("is-visible")
            observer.unobserve(entry.target)
          }
        })
      },
      { rootMargin: "0px 0px -8% 0px", threshold: 0.1 }
    )
    targets.forEach((el) => observer.observe(el))
  }

  /* =========================================================
     Barra de progresso de leitura
     ========================================================= */
  const progress = $(".progress")

  function updateProgress() {
    const max = document.documentElement.scrollHeight - window.innerHeight
    const ratio = max > 0 ? window.scrollY / max : 0
    progress?.style.setProperty("--progress", ratio.toFixed(4))
  }

  window.addEventListener("scroll", updateProgress, { passive: true })
  window.addEventListener("resize", updateProgress)
  updateProgress()

  /* =========================================================
     Recado para quem abre o DevTools
     ========================================================= */
  const spectrum = ["#fc618d", "#fd9353", "#fce566", "#7bd88f", "#5ad4e6", "#948ae3"]
  console.log(
    "%c█%c█%c█%c█%c█%c█",
    ...spectrum.map((c) => `color:${c};font-size:18px;line-height:1`)
  )
  console.log(
    "%cCurioso? Eu também. 👋%c\nO código está em https://github.com/rodrigoacs\nDica: pressione Ctrl+K na página.",
    "color:#7bd88f;font:600 14px monospace",
    "color:inherit;font:12px monospace"
  )

  /* =========================================================
     Galeria de telas dos projetos
     img/projetos/manifest.json é gerado por scripts/capturar-telas.mjs;
     projeto fora do manifest (ou manifest ausente) simplesmente não ganha galeria.
     ========================================================= */
  function updateShotLabels() {
    $$(".shots summary").forEach((s) => (s.textContent = t().shots(s.dataset.count)))
  }

  function buildGallery(job, shots) {
    const details = document.createElement("details")
    details.className = "shots"
    const summary = document.createElement("summary")
    summary.dataset.count = shots.length
    details.append(summary)

    const strip = document.createElement("div")
    strip.className = "shots-strip"
    shots.forEach(({ src, alt }) => {
      const link = document.createElement("a")
      link.href = src
      link.target = "_blank"
      link.rel = "noopener"
      const img = document.createElement("img")
      img.src = src
      img.alt = alt
      img.loading = "lazy" // dentro do <details> fechado, só baixa ao abrir
      img.decoding = "async"
      img.width = 1280
      img.height = 800
      link.append(img)
      strip.append(link)
    })
    details.append(strip)
    details.addEventListener("toggle", () => {
      if (details.open) track("telas", { projeto: job.dataset.projeto })
    })

    const tags = $("ul.tags", job)
    if (tags) tags.before(details)
    else job.append(details)
  }

  fetch("img/projetos/manifest.json", { cache: "no-cache" })
    .then((res) => (res.ok ? res.json() : {}))
    .then((manifest) => {
      $$("[data-projeto]").forEach((job) => {
        const shots = manifest[job.dataset.projeto]
        if (Array.isArray(shots) && shots.length) buildGallery(job, shots)
      })
      updateShotLabels()
    })
    .catch(() => { })

  /* Inicialização */
  applyLang(lang)
})()
__FIM_ARQUIVO_3__

escrever 'robots.txt' <<'__FIM_ARQUIVO_4__'
User-agent: *
Allow: /
Disallow: /scripts/

Sitemap: https://rodrigoacs.com/sitemap.xml
__FIM_ARQUIVO_4__

escrever 'sitemap.xml' <<'__FIM_ARQUIVO_5__'
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xhtml="http://www.w3.org/1999/xhtml">
  <url>
    <loc>https://rodrigoacs.com/</loc>
    <xhtml:link rel="alternate" hreflang="pt-BR" href="https://rodrigoacs.com/" />
    <xhtml:link rel="alternate" hreflang="en" href="https://rodrigoacs.com/?lang=en" />
    <xhtml:link rel="alternate" hreflang="x-default" href="https://rodrigoacs.com/" />
  </url>
  <url>
    <loc>https://rodrigoacs.com/?lang=en</loc>
    <xhtml:link rel="alternate" hreflang="pt-BR" href="https://rodrigoacs.com/" />
    <xhtml:link rel="alternate" hreflang="en" href="https://rodrigoacs.com/?lang=en" />
    <xhtml:link rel="alternate" hreflang="x-default" href="https://rodrigoacs.com/" />
  </url>
</urlset>
__FIM_ARQUIVO_5__

escrever '.dockerignore' <<'__FIM_ARQUIVO_6__'
scripts/
.github/
.git/
.eslintrc.cjs
__FIM_ARQUIVO_6__

escrever 'img/projetos/manifest.json' <<'__FIM_ARQUIVO_7__'
{}
__FIM_ARQUIVO_7__

escrever 'scripts/lib/navegador.mjs' <<'__FIM_ARQUIVO_8__'
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
__FIM_ARQUIVO_8__

escrever 'scripts/gerar-pdfs.mjs' <<'__FIM_ARQUIVO_9__'
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
__FIM_ARQUIVO_9__

escrever 'scripts/capturar-telas.mjs' <<'__FIM_ARQUIVO_10__'
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
__FIM_ARQUIVO_10__

escrever 'scripts/og-image.html' <<'__FIM_ARQUIVO_11__'
<!doctype html>
<!-- Modelo da og-image.png (1200×630), a imagem do preview ao compartilhar o link.
     Gerada por: node scripts/gerar-pdfs.mjs  (cores = paleta escura do site) -->
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;500&family=IBM+Plex+Sans:wght@400;600;700&display=block"
    />
    <style>
      * {
        box-sizing: border-box;
        margin: 0;
      }

      html,
      body {
        width: 1200px;
        height: 630px;
        overflow: hidden;
        background: #222222;
        color: #f7f1ff;
        font-family: 'IBM Plex Sans', sans-serif;
      }

      .card {
        position: relative;
        display: flex;
        flex-direction: column;
        justify-content: center;
        height: 100%;
        padding: 0 96px;
        background:
          radial-gradient(circle at 88% 18%, rgb(148 138 227 / 0.16), transparent 42%),
          radial-gradient(circle at 8% 95%, rgb(123 216 143 / 0.12), transparent 40%);
      }

      /* Faixa do espectro, igual ao topo do site */
      .card::before {
        content: '';
        position: absolute;
        inset: 0 0 auto;
        height: 10px;
        background: linear-gradient(
          90deg,
          #fc618d 0 16.66%,
          #fd9353 0 33.33%,
          #fce566 0 50%,
          #7bd88f 0 66.66%,
          #5ad4e6 0 83.33%,
          #948ae3 0
        );
      }

      .eyebrow {
        display: inline-flex;
        align-items: center;
        gap: 12px;
        align-self: flex-start;
        margin-bottom: 28px;
        padding: 8px 18px;
        border-radius: 999px;
        background: rgb(123 216 143 / 0.14);
        color: #7bd88f;
        font: 500 22px/1 'IBM Plex Mono', monospace;
        letter-spacing: 0.1em;
        text-transform: uppercase;
      }

      .eyebrow::before {
        content: '';
        width: 10px;
        height: 10px;
        border-radius: 50%;
        background: currentColor;
      }

      h1 {
        font-size: 104px;
        font-weight: 700;
        line-height: 1;
        letter-spacing: -0.03em;
      }

      .stack {
        margin-top: 30px;
        color: #c1c0c0;
        font-size: 32px;
      }

      .stack b {
        color: #f7f1ff;
        font-weight: 600;
      }

      .url {
        position: absolute;
        right: 96px;
        bottom: 64px;
        left: 96px;
        display: flex;
        justify-content: space-between;
        color: #939293;
        font: 400 26px 'IBM Plex Mono', monospace;
      }

      .url span:first-child {
        color: #fce566;
      }
    </style>
  </head>
  <body>
    <div class="card">
      <p class="eyebrow">Desenvolvedor Full Stack</p>
      <h1>Rodrigo Soares</h1>
      <p class="stack">
        <b>Node.js</b> · <b>TypeScript</b> · <b>Vue.js</b> · <b>React Native</b> ·
        <b>PostgreSQL</b> · <b>Docker</b>
      </p>
      <p class="url"><span>❯ rodrigoacs.com</span><span>Congonhas - MG · Remoto</span></p>
    </div>
  </body>
</html>
__FIM_ARQUIVO_11__

escrever 'scripts/telas.json' <<'__FIM_ARQUIVO_12__'
{
  "largura": 1280,
  "altura": 800,
  "qualidade": 82,
  "aguardar": 1500,
  "projetos": {
    "librishelf": [
      { "nome": "biblioteca-publica", "url": "https://librishelf.com/u/SEU_USUARIO" },
      { "nome": "estante", "url": "https://librishelf.com/books" },
      { "nome": "dashboard", "url": "https://librishelf.com/dashboard" }
    ],
    "arena": [
      { "nome": "pagina-publica-da-liga", "url": "http://localhost:8080/l/ID_DA_LIGA" },
      { "nome": "torneio", "url": "http://localhost:8080/tournament" }
    ],
    "mercadia": [
      { "nome": "colecao", "url": "http://localhost:3003/" }
    ]
  }
}
__FIM_ARQUIVO_12__

escrever '.github/workflows/artefatos.yml' <<'__FIM_ARQUIVO_13__'
# Regera os PDFs do currículo e a og-image sempre que o conteúdo do site muda,
# e commita o resultado na própria branch. O script só regrava um arquivo quando
# o conteúdo mudou, então pushes que não mexem no currículo não geram commit.
#
# Commits feitos com o GITHUB_TOKEN não disparam workflows de novo (sem loop).
# Depois que a Action commitar, faça "git pull" antes do próximo push.

name: Regerar PDFs e og-image

on:
  push:
    branches: [simple]
    paths:
      - index.html
      - style.css
      - script.js
      - scripts/**
  workflow_dispatch:

permissions:
  contents: write

concurrency:
  group: artefatos-${{ github.ref }}
  cancel-in-progress: true

jobs:
  gerar:
    runs-on: ubuntu-24.04
    steps:
      - uses: actions/checkout@v5

      - uses: actions/setup-node@v5
        with:
          node-version: 22

      # O runner já vem com o Google Chrome em /opt/google/chrome. É o binário que o
      # perfil AppArmor do Ubuntu 24.04 libera, então o sandbox funciona normalmente.
      - name: Gerar PDFs e og-image
        env:
          CHROME_PATH: /opt/google/chrome/chrome
        run: node scripts/gerar-pdfs.mjs

      # Se um dia falhar com "No usable sandbox", troque o passo acima por:
      #   sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
      #   node scripts/gerar-pdfs.mjs

      - name: Commitar se mudou
        run: |
          git config user.name "github-actions[bot]"
          git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
          git add curriculo-rodrigo-soares.pdf resume-rodrigo-soares.pdf og-image.png
          if git diff --cached --quiet; then
            echo "Nada mudou nos artefatos."
            exit 0
          fi
          git commit -m "chore(cv): regera PDFs e og-image"
          git push
__FIM_ARQUIVO_13__

# ---------- Limpeza ----------
echo "▸ Limpeza"
if [[ -f gerar-pdfs.mjs ]]; then
  rm gerar-pdfs.mjs
  echo "  ✓ removido gerar-pdfs.mjs da raiz (agora fica em scripts/)"
fi

# ---------- Umami (fora do repositório!) ----------
echo "▸ Umami em $UMAMI_DIR (fora do repo: o nginx do site serve a pasta do repo inteira)"
escrever "$UMAMI_DIR/docker-compose.yml" <<'__FIM_ARQUIVO_14__'
# Umami (analytics próprio, sem cookies) para rodrigoacs.com
# Fica numa pasta SEPARADA do repositório do site: o site monta a pasta do repo
# inteira no nginx, então um .env ali dentro seria baixável por qualquer um.
#
#   cp .env.example .env   # e preencha
#   docker compose up -d
#
# Não publica porta: o nginx (rede "proxy") fala com o Umami por http://umami:3000.

services:
  umami:
    image: ghcr.io/umami-software/umami:latest
    container_name: umami
    restart: unless-stopped
    init: true
    environment:
      DATABASE_URL: postgresql://umami:${DB_PASSWORD}@umami-db:5432/umami
      APP_SECRET: ${APP_SECRET}
      # Nome do script de rastreio. "script.js" do Umami é bloqueado por muitos adblockers.
      TRACKER_SCRIPT_NAME: stats.js
    depends_on:
      umami-db:
        condition: service_healthy
    healthcheck:
      test: ['CMD-SHELL', 'curl -fsS http://localhost:3000/api/heartbeat || exit 1']
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - proxy
      - interno

  umami-db:
    image: postgres:15-alpine
    container_name: umami-db
    restart: unless-stopped
    environment:
      POSTGRES_DB: umami
      POSTGRES_USER: umami
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - umami-db-data:/var/lib/postgresql/data
    healthcheck:
      test: ['CMD-SHELL', 'pg_isready -U $${POSTGRES_USER} -d $${POSTGRES_DB}']
      interval: 5s
      timeout: 5s
      retries: 5
    networks:
      - interno

volumes:
  umami-db-data:

networks:
  proxy:
    external: true
  # Só o Umami enxerga o banco
  interno: {}
__FIM_ARQUIVO_14__

escrever "$UMAMI_DIR/.env.example" <<'__FIM_ARQUIVO_15__'
# Copie para .env e preencha. Gere valores com: openssl rand -base64 32
APP_SECRET=
DB_PASSWORD=
__FIM_ARQUIVO_15__

escrever "$UMAMI_DIR/nginx-analytics.conf" <<'__FIM_ARQUIVO_16__'
# analytics.rodrigoacs.com → container "umami" (rede proxy)
# Antes: crie no DNS (Hostinger) um registro A "analytics" apontando para o IP da VPS
# e emita o certificado do subdomínio do mesmo jeito que você faz para os outros sites.
# Ajuste os caminhos ssl_certificate se o seu esquema for diferente do certbot.

server {
    listen 80;
    server_name analytics.rodrigoacs.com;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }

    location / {
        return 301 https://$host$request_uri;
    }
}

server {
    listen 443 ssl;
    http2 on;
    server_name analytics.rodrigoacs.com;

    ssl_certificate     /etc/letsencrypt/live/analytics.rodrigoacs.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/analytics.rodrigoacs.com/privkey.pem;

    location / {
        # Resolve o container a cada requisição: o nginx sobe mesmo com o Umami parado
        resolver 127.0.0.11 valid=30s;
        set $umami http://umami:3000;
        proxy_pass $umami;

        proxy_http_version 1.1;
        proxy_set_header Host              $host;
        # IP real do visitante (o Umami usa para o país; o IP não é armazenado)
        proxy_set_header X-Real-IP         $remote_addr;
        proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
__FIM_ARQUIVO_16__

if [[ ! -f "$UMAMI_DIR/.env" ]]; then
  {
    echo "APP_SECRET=$(openssl rand -base64 32)"
    echo "DB_PASSWORD=$(openssl rand -hex 24)"
  } > "$UMAMI_DIR/.env"
  chmod 600 "$UMAMI_DIR/.env"
  echo "  ✓ $UMAMI_DIR/.env com segredos aleatórios (copie a pasta para a VPS)"
fi

# ---------- PDFs e og-image ----------
if [[ $GERAR -eq 1 ]]; then
  echo "▸ Gerando PDFs e og-image (precisa do Brave/Chrome e de internet para as fontes)"
  node scripts/gerar-pdfs.mjs
fi

cat <<'__FIM_RESUMO__'

Pronto. Próximos passos:
  1. git status && git diff                      # revise
  2. Abra o index.html no navegador e confira
  3. Commite e dê push (a GitHub Action passa a regerar PDFs/og-image sozinha)
  4. Umami: suba a pasta do Umami na VPS (docker compose up -d), configure o
     nginx-analytics.conf, crie o site no painel e cole o ID em data-website-id
  5. Telas dos projetos: edite scripts/telas.json e rode
       node scripts/capturar-telas.mjs
__FIM_RESUMO__