export default   {
  nav: {
    explorer: "EXPLORADOR",
    browser: "Navegador Simples"
  },
  settings: {
    title: "Configurações",
    comment: "Edite os valores abaixo para customizar o ambiente",
    fontSize: "Tamanho da Fonte",
    theme: "Tema de Cor"
  },
  terminal: {
    boot: "Portfolio Terminal v1.0.0 inicializado.",
    access: "Acesso concedido. Digite",
    help_hint: "para listar os comandos.",
    help_title: "Comandos disponíveis:",
    help_desc: "Mostra esta lista",
    neofetch_desc: "Mostra informações do sistema",
    github_desc: "Busca stats em tempo real do GitHub",
    whoami_desc: "Resumo do desenvolvedor",
    contact_desc: "Mostra redes e e-mail",
    pwd_desc: "Print working directory",
    ls_desc: "Lista arquivos do projeto",
    date_desc: "Mostra a data atual do host",
    matrix_desc: "Enter the Matrix",
    clear_desc: "Limpa o terminal",
    contact_success: "✔ Conexão estabelecida. Canais disponíveis:",
    whoami_text: "Rodrigo Augusto Correa Soares<br>Fullstack Developer focado em Node.js e Java.<br>Interesses adicionais: Magic: The Gathering (Commander) e Impressão 3D.",
    matrix_text: "Wake up, Neo...",
    github_fetching: "Conectando à API do GitHub (rodrigoacs)...",
    github_success: "Sincronização concluída com sucesso",
    user: "Usuário",
    followers: "Seguidores",
    repos: "Repositórios Públicos",
    last_repos: "Últimos repositórios ativos:",
    open_profile: "Abrir Perfil Completo no GitHub",
    not_found: "comando não encontrado",
    help_footer: "Digite 'help' para comandos válidos.",
    permission_denied: "permissão negada. O incidente será reportado. Nice try. ;)"
  },
  bio: {
    hello: 'olá, eu sou o Rodrigo!',
    p1: 'Sou desenvolvedor de software com foco em criar soluções escaláveis e otimizar pipelines de dados. Comecei a programar lá em 2018 e, hoje cursando Sistemas de Informação, construí uma base que me permite atuar de ponta a ponta nas aplicações. Tenho bastante vivência no ecossistema JavaScript/Node.js e na criação de interfaces com Vue.js. Mas minha especialidade mesmo é o backend: desenvolvo APIs RESTful, middlewares e arquiteturas de integração de dados em tempo real usando Node.js e SQL. Tenho experiência prática resolvendo desafios complexos de ETL e conectando sistemas gigantes do varejo, como Salesforce, SAP e Winthor. Fora do trabalho, você me encontra lendo, jogando Magic: The Gathering ou mexendo com impressão 3D.',
  },
  projects: {
    title: 'projetos',
    comment: "Catálogo de projetos pessoais e em desenvolvimento.",
    dynamic_data: "Dados carregados dinamicamente via src/data/projects.json",
    preview: "Visualizar Projeto",
    repo: "Repositório"
  },
  blog: {
    title: 'leia alguns dos meus posts',
  },
  cv: {
    filename: "cv_rodrigosoares.pdf",
    email: "rodrigohths{'@'}gmail.com",
    github: "https://github.com/rodrigoacs",
    linkedin: "https://www.linkedin.com/in/rodrigoacsoares/",
    website: "https://rodrigoacs.com",
    summary: "Desenvolvedor de Software focado na construção de soluções robustas, escaláveis e na otimização de pipelines de dados. Sólida experiência em JavaScript e Node.js, especializado na criação e otimização de APIs RESTful, desenvolvimento de middlewares e soluções de integração em larga escala. Possui também vivência no desenvolvimento de interfaces dinâmicas e responsivas utilizando Vue.js, atuando de ponta a ponta nas aplicações. Experiência prática com ingestão, transformação e sincronização de dados (ETL) entre sistemas complexos (como Salesforce, SAP e Winthor). Proficiente em esteiras DevOps (CI/CD), Docker e metodologias ágeis, buscando entregar código de alta qualidade para suportar a transformação tecnológica de grandes clientes.",
    experiences: [
      { company: "S-Cube", role: "Desenvolvedor de Software", period: "Dezembro de 2025 - Atual", description: "Desenvolvimento e arquitetura de chatbots inteligentes voltados para automação de suporte, vendas e triagem, integrando a API Whatsapp com modelos de IA Generativa (OpenAI) para criação de fluxos dinâmicos. Implementação da persistência de contexto e PostgreSQL, aliada à gestão de infraestrutura e pipelines via Dokploy (Docker)." },
      { company: "B2List", role: "Desenvolvedor de Software", period: "Setembro de 2024 - Dezembro de 2025", description: "Construção e manutenção de microsserviços e pipelines de dados (ETL) em Node.js, garantindo a ingestão e sincronização eficiente de informações em larga escala. Foco na construção de APIs performáticas." },
      { company: "CSN Mineração", role: "Estagiário de Desenvolvimento", period: "Agosto de 2024 - Novembro de 2024", description: "Análise de performance de sistemas, incluindo otimização de consultas SQL (tunning) e monitoramento da saúde de aplicações." },
      { company: "CLI Consultoria", role: "Analista de Desenvolvimento de Sistemas", period: "Março de 2024 - Julho de 2024", description: "Otimização de APIs RESTful para consumo de dados em tempo real. Desenvolvimento de middlewares para orquestração e transformação de dados entre sistemas legados (SAP) e terceiros (Salesforce)." },
      { company: "CLI Consultoria", role: "Estagiário de Desenvolvimento", period: "Fevereiro de 2023 - Março de 2024", description: "Desenvolvimento de rotinas de ingestão de dados (MongoDB, SAP, Winthor, Salesforce). Manutenção e otimização de pipelines de dados e atuação em ambientes cloud com AWS EC2." }
    ],
    educations: [
      { time: "Setembro de 2021 - Presente", local: "IFMG, Ouro Branco - MG", course: "Bacharelado em Sistemas de Informação" },
      { time: "Janeiro de 2018 - Abril de 2021", local: "IFMG, Congonhas - MG", course: "Técnico Integrado em Mecânica" }
    ],
    skills: {
      lang: "Java, JavaScript (Node.js), Python, SQL, Kotlin",
      arch: "APIs RESTful, Arquitetura de Microsserviços, Design Patterns",
      db: "PostgreSQL, MySQL, Oracle, MongoDB",
      devops: "Docker, Git, GitHub Actions, CI/CD, AWS EC2, Linux (Ubuntu, CentOS)",
      method: "Metodologias Ágeis, Code Review, Testes Unitários"
    },
    download_comment: "Clique no link abaixo para baixar o arquivo"
  }
}