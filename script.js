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
    },
  }

  const EN = {
    role: "Full Stack Developer",
    location: "Congonhas - MG, Brazil",
    website: "Website",
    download: "Resume (PDF)",
    "h.summary": "Professional Summary",
    "h.experience": "Professional Experience",
    "h.projects": "Personal Projects",
    "h.education": "Education",
    "h.skills": "Skills &amp; Technologies",
    "filter.label": "Filter by technology",
    headline: "Full Stack Developer",
    summary: `Full Stack Developer with 3+ years of software development experience (including internships), focused on
    <strong>back-end</strong> and <strong>systems integration</strong>. I work with
    <strong>JavaScript</strong> and <strong>TypeScript</strong>, <strong>Node.js</strong>
    (<strong>Express</strong>), <strong>Vue.js</strong>, <strong>React Native</strong> (Expo),
    <strong>PostgreSQL</strong> and <strong>MongoDB</strong>. Experienced with
    <strong>REST APIs</strong>, <strong>microservices</strong>, data pipelines (ETL) and integration
    middleware for ERPs and CRMs (SAP, Winthor, Salesforce), as well as generative AI chatbots
    (OpenAI) integrated with WhatsApp. On the infrastructure side, I work with
    <strong>Docker</strong>, <strong>Nginx</strong>, <strong>Linux</strong>, <strong>Git</strong>
    and <strong>AWS</strong> (EC2); in personal projects, I apply <strong>JWT</strong>
    authentication and automated testing with <strong>Jest</strong>.`,
    "scube.title": `<strong>Software Developer</strong><br />
    <em>S-Cube | 12/2025 - 10/2026</em>`,
    "scube.1": `Built support, sales and triage chatbots in <strong>Node.js</strong>, integrating the
    <strong>WhatsApp API</strong> with the <strong>OpenAI API</strong> (generative AI) to deliver
    dynamic conversation flows.`,
    "scube.2": `Implemented context and conversation history persistence in
    <strong>PostgreSQL</strong> and automated service deployment with <strong>Docker</strong> via
    Dokploy.`,
    "scube.3": `Developed a <strong>React Native</strong> mobile app (Expo Router +
    <strong>TypeScript</strong>) for a client's member and event management.`,
    "b2list.title": `<strong>Software Developer</strong><br />
    <em>B2List | 09/2024 - 12/2025</em>`,
    "b2list.1": `Built and maintained <strong>microservices</strong> and data pipelines
    (<strong>ETL</strong>) in <strong>Node.js</strong> to ingest and synchronize large volumes of
    data.`,
    "b2list.2": `Developed <strong>APIs</strong> in <strong>Node.js</strong> for the platform's
    business rules, focusing on performance, quality and code maintainability.`,
    "csn.title": `<strong>Software Development Intern</strong><br />
    <em>CSN Mineração | 08/2024 - 11/2024</em>`,
    "csn.1": `Optimized <strong>SQL</strong> queries (tuning) and monitored the health and
    performance of production applications.`,
    "cli2.title": `<strong>Systems Development Analyst</strong><br />
    <em>CLI Consultoria | 03/2024 - 07/2024</em>`,
    "cli2.1": `Optimized <strong>RESTful APIs</strong> for real-time data consumption in critical
    systems, focusing on low latency and availability.`,
    "cli2.2": `Developed <strong>middleware</strong> to orchestrate and transform data between
    <strong>SAP</strong> and <strong>Salesforce</strong>, evolving legacy code.`,
    "cli2.3": "Contributed to the evolution of the architecture and the scalability of applications.",
    "cli1.title": `<strong>Software Development Intern</strong><br />
    <em>CLI Consultoria | 02/2023 - 03/2024</em>`,
    "cli1.1": `Built data ingestion routines from APIs, <strong>MongoDB</strong> databases, ERPs
    (SAP, Winthor) and CRM (Salesforce).`,
    "cli1.2": `Maintained and optimized existing data pipelines, including legacy code, improving
    the performance and reliability of data flows.`,
    "cli1.3": `Administered <strong>Linux</strong> servers in an <strong>AWS</strong> (EC2) cloud
    environment, following DevOps practices.`,
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
    "librishelf.1": `Personal library to catalog and track book collections, with
    <strong>Vue 3</strong>, PrimeVue, vue-i18n (Portuguese and English) and Chart.js on the
    front-end and <strong>Express 5</strong> + <strong>PostgreSQL</strong> on the back-end, with
    custom migrations, JWT authentication in httpOnly cookies, cover processing with sharp,
    transactional emails (Nodemailer) and tests with <strong>Jest</strong> and Supertest. Deployed
    with Docker Compose and Nginx.`,
    "edu.1": `<strong>Bachelor's Degree in Information Systems</strong><br />
    IFMG, Ouro Branco - MG, Brazil | 09/2021 - in progress`,
    "edu.2": `<strong>Technical Diploma in Mechanics (integrated with high school)</strong><br />
    IFMG, Congonhas - MG, Brazil | 01/2018 - 04/2021`,
    "skills.1": "<strong>Programming Languages:</strong> JavaScript, TypeScript, SQL, Java, Python, Kotlin.",
    "skills.2": "<strong>Back-end:</strong> Node.js, Express, REST (RESTful) APIs, JWT authentication, microservices, ETL, systems integration (SAP, Winthor, Salesforce), Design Patterns.",
    "skills.3": "<strong>Front-end:</strong> Vue.js (Vue 3), HTML5, CSS3, Tailwind CSS, PrimeVue, Bootstrap, Chart.js, PWA.",
    "skills.4": "<strong>Mobile:</strong> React Native (Expo, Expo Router).",
    "skills.5": "<strong>Databases:</strong> PostgreSQL, MySQL, Oracle, MongoDB.",
    "skills.6": "<strong>DevOps &amp; Cloud:</strong> Docker, Docker Compose, Nginx, Git, GitHub Actions, CI/CD, AWS (EC2), Linux (Debian, Ubuntu, CentOS).",
    "skills.7": "<strong>Quality:</strong> Automated testing (Jest, Supertest), Code Review.",
    "skills.8": "<strong>Methodologies:</strong> Agile, Jira.",
    "skills.9": "<strong>AI &amp; Messaging:</strong> OpenAI API, WhatsApp chatbots.",
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
    }
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
      $$(".job").slice(0, 5).forEach((job) => {
        const [title, meta] = $(".job-title", job).innerText.split("\n")
        termPrint(`▸ ${title}`, "accent")
        termPrint(`  ${meta}`, "muted")
      })
    },
    projects() {
      $$(".job").slice(5).forEach((job) => {
        termPrint(`▸ ${$(".job-title strong", job).innerText}`, "accent")
        $$(".job-links a", job).forEach((a) => printLink(`  ${a.textContent}`, a.href))
      })
    },
    skills() {
      sectionText(".container > ul li").forEach((line) => termPrint(`• ${line}`))
    },
    contact() {
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

  /* Inicialização */
  applyLang(lang)
})()