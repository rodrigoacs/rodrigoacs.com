<template>
  <div
    class="bottom-panel"
    :class="{ 'is-open': isOpen }"
  >
    <div
      class="panel-header"
      @click="togglePanel"
    >
      <div class="panel-tabs">
        <span class="panel-tab">PROBLEMS</span>
        <span class="panel-tab">OUTPUT</span>
        <span class="panel-tab">DEBUG CONSOLE</span>
        <span class="panel-tab active">TERMINAL</span>
      </div>
      <div class="panel-actions">
        <span class="action-icon">^</span>
        <span
          class="action-icon"
          @click.stop="closePanel"
        >x</span>
      </div>
    </div>

    <div
      class="panel-content"
      @click="focusInput"
    >
      <div
        v-for="(log, index) in terminalHistory"
        :key="index"
        class="terminal-history"
      >
        <div
          class="terminal-line"
          v-if="log.type === 'command'"
        >
          <span class="term-path">~/rodrigoacs-portfolio</span> <span class="term-branch">git:(main)</span> <span
            class="term-x"
          >x</span><br>
          <span class="term-prompt">❯</span> <span class="term-text">{{ log.content }}</span>
        </div>
        <div
          class="terminal-output"
          v-else
          v-html="log.content"
        ></div>
      </div>

      <div
        class="terminal-line mt-2"
        v-show="!isBooting"
      >
        <span class="term-path">~/rodrigoacs-portfolio</span> <span class="term-branch">git:(main)</span> <span
          class="term-x"
        >x</span><br>
        <span class="term-prompt">❯</span>
        <input
          ref="termInput"
          type="text"
          class="term-input"
          v-model="currentCommand"
          @keydown.enter="executeCommand"
          :disabled="isInputDisabled"
          spellcheck="false"
          autocomplete="off"
        />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, nextTick } from 'vue'
import { useSettings } from '@/composables/useSettings'

const { toggleMatrix } = useSettings()

const isOpen = ref(false)
const termInput = ref(null)
const currentCommand = ref('')
const terminalHistory = ref([])

const hasBooted = ref(false)
const isBooting = ref(false)
const isInputDisabled = ref(false)

function togglePanel() {
  isOpen.value = !isOpen.value
  if (isOpen.value) {
    if (!hasBooted.value) {
      bootTerminal()
    } else {
      focusInput()
    }
  }
}

function closePanel() {
  isOpen.value = false
}

function focusInput() {
  if (!isInputDisabled.value) {
    nextTick(() => {
      termInput.value?.focus()
    })
  }
}

function bootTerminal() {
  hasBooted.value = true
  isBooting.value = true
  isInputDisabled.value = true

  const bootCmd = 'bash start_portfolio.sh'
  let i = 0

  terminalHistory.value.push({ type: 'command', content: '' })

  const typingInterval = setInterval(() => {
    terminalHistory.value[terminalHistory.value.length - 1].content = bootCmd.substring(0, i)
    i++

    if (i > bootCmd.length) {
      clearInterval(typingInterval)
      setTimeout(() => {
        terminalHistory.value.push({
          type: 'output',
          content: '<span class="info">Portfolio Terminal v1.0.0 inicializado.</span><br><span class="info">Acesso concedido. Digite <span class="success">help</span> para listar os comandos.</span>'
        })
        isBooting.value = false
        isInputDisabled.value = false
        focusInput()
        scrollToBottom()
      }, 400)
    }
  }, 25)
}

function scrollToBottom() {
  nextTick(() => {
    const contentDiv = document.querySelector('.panel-content')
    if (contentDiv) contentDiv.scrollTop = contentDiv.scrollHeight
  })
}

function executeCommand() {
  const cmdRaw = currentCommand.value.trim()
  const cmdLower = cmdRaw.toLowerCase()
  if (!cmdLower) return

  terminalHistory.value.push({ type: 'command', content: cmdRaw })

  let output = ''
  switch (cmdLower) {
    case 'help':
      output = `
        <span class="success">Comandos disponíveis:</span><br>
        &nbsp;&nbsp;<span class="term-path">help</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mostra esta lista<br>
        &nbsp;&nbsp;<span class="term-path">neofetch</span>&nbsp;&nbsp;Mostra informações do sistema<br>
        &nbsp;&nbsp;<span class="term-path">github</span>&nbsp;&nbsp;&nbsp;&nbsp;Busca stats em tempo real do GitHub<br>
        &nbsp;&nbsp;<span class="term-path">whoami</span>&nbsp;&nbsp;&nbsp;&nbsp;Resumo do desenvolvedor<br>
        &nbsp;&nbsp;<span class="term-path">contact</span>&nbsp;&nbsp;&nbsp;Mostra redes e e-mail<br>
        &nbsp;&nbsp;<span class="term-path">pwd</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Print working directory<br>
        &nbsp;&nbsp;<span class="term-path">ls</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lista arquivos do projeto<br>
        &nbsp;&nbsp;<span class="term-path">date</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mostra a data atual do host<br>
        &nbsp;&nbsp;<span class="term-path">matrix</span>&nbsp;&nbsp;&nbsp;&nbsp;Enter the Matrix<br> 
        &nbsp;&nbsp;<span class="term-path">clear</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Limpa o terminal<br>
      `
      break
    case 'contact':
      output = `
        <span class="success">✔ Conexão estabelecida.</span> Canais disponíveis:<br><br>
        &nbsp;&nbsp;<a href="mailto:rodrigohths@gmail.com" class="link" target="_blank">[E-mail]  rodrigohths@gmail.com</a><br>
        &nbsp;&nbsp;<a href="https://www.linkedin.com/in/rodrigoacsoares/" class="link" target="_blank">[LinkedIn] rodrigoacsoares</a><br>
        &nbsp;&nbsp;<a href="https://github.com/rodrigoacs" class="link" target="_blank">[GitHub]   rodrigoacs</a>
      `
      break
    case 'whoami':
      output = `<span class="info">Rodrigo Augusto Correa Soares<br>Fullstack Developer focado em Node.js e Java.<br>Interesses adicionais: Magic: The Gathering (Commander) e Impressão 3D.</span>`
      break
    case 'pwd':
      output = `<span class="text">/home/rodrigo/projects/rodrigoacs-portfolio</span>`
      break
    case 'ls':
      output = `<span class="term-path">src/</span>  <span class="term-path">public/</span>  <span class="success">package.json</span>  <span class="success">vite.config.js</span>  README.md`
      break
    case 'date':
      output = `<span class="text">${new Date().toString()}</span>`
      break
    case 'matrix':
      toggleMatrix()
      output = `<span class="success">Wake up, Neo...</span>`
      break

    // ---- NOVA INTEGRAÇÃO COM A API DO GITHUB ----
    case 'github':
      output = `<span class="info">📡 Conectando à API do GitHub (rodrigoacs)...</span>`
      terminalHistory.value.push({ type: 'output', content: output })

      // Oculta input temporariamente simulando processamento
      isInputDisabled.value = true

      fetch('https://api.github.com/users/rodrigoacs')
        .then(res => {
          if (!res.ok) throw new Error('API Rate Limit excedido ou erro de rede.')
          return res.json()
        })
        .then(data => {
          // Busca secundária: Os 3 repositórios mais recentemente atualizados
          return fetch('https://api.github.com/users/rodrigoacs/repos?sort=updated&per_page=3')
            .then(res => res.json())
            .then(repos => ({ user: data, repos }))
        })
        .then(({ user, repos }) => {
          let reposHtml = repos.map(r => `&nbsp;&nbsp;&nbsp;<span class="success">➜</span> <a href="${r.html_url}" target="_blank" class="link">${r.name}</a> <span class="info">(${r.language || 'N/A'})</span>`).join('<br>')

          const ghOutput = `
            <div style="margin-top: 10px; border-left: 2px solid #a9dc76; padding-left: 10px; line-height: 1.6;">
              <span class="success">✔ Sincronização concluída com sucesso</span><br><br>
              <span class="term-path">Usuário:</span> ${user.login}<br>
              <span class="term-path">Bio:</span> ${user.bio || 'Desenvolvedor'}<br>
              <span class="term-path">Seguidores:</span> ${user.followers} | <span class="term-path">Repositórios Públicos:</span> ${user.public_repos}<br><br>
              <span class="term-path">Últimos repositórios ativos:</span><br>
              ${reposHtml}<br><br>
              <a href="${user.html_url}" target="_blank" class="link">[Abrir Perfil Completo no GitHub]</a>
            </div>
          `
          terminalHistory.value.push({ type: 'output', content: ghOutput })
        })
        .catch(err => {
          terminalHistory.value.push({ type: 'output', content: `<span style="color: #ff6188;">Erro: ${err.message}</span>` })
        })
        .finally(() => {
          isInputDisabled.value = false
          currentCommand.value = ''
          focusInput()
          scrollToBottom()
        })
      return // Retorno antecipado pois a operação é assíncrona
    // ---------------------------------------------

    case 'neofetch':
      output = `
<div style="display: flex; gap: 20px; align-items: center; flex-wrap: wrap;">
  <div style="color: var(--theme-accent); font-weight: bold; line-height: 1.2;">
&nbsp;&nbsp;&nbsp;&nbsp;____<br>
&nbsp;&nbsp;&nbsp;/ __ \\<br>
&nbsp;&nbsp;|&nbsp;&nbsp;|&nbsp;&nbsp;|<br>
&nbsp;&nbsp;|&nbsp;&nbsp;|__|&nbsp;|<br>
&nbsp;&nbsp;&nbsp;\\____/
  </div>
  <div>
    <span style="color: var(--theme-accent); font-weight: bold;">rodrigo</span>@<span style="color: var(--theme-accent); font-weight: bold;">cyberdeck</span><br>
    -------------------<br>
    <span style="color: #ff6188;">OS</span>: Ubuntu 22.04 LTS (WSL2)<br>
    <span style="color: #ff6188;">Host</span>: Web Browser<br>
    <span style="color: #ff6188;">Kernel</span>: Vue.js Engine<br>
    <span style="color: #ff6188;">Uptime</span>: ∞<br>
    <span style="color: #ff6188;">Shell</span>: zsh<br>
    <span style="color: #ff6188;">Terminal</span>: VS Code Integrated<br>
    <span style="color: #ff6188;">CPU</span>: Human Brain (Highly Parallel)<br>
    <span style="color: #ff6188;">Memory</span>: Needs coffee...<br>
  </div>
</div>`
      break
    case 'clear':
      terminalHistory.value = []
      break
    default:
      if (cmdLower.startsWith('sudo ')) {
        output = `<span style="color: #ff6188;">bash: permissão negada. O incidente será reportado. Nice try. ;)</span>`
      } else {
        output = `<span style="color: #ff6188;">bash: comando não encontrado: ${cmdRaw}</span><br><span class="info">Digite 'help' para comandos válidos.</span>`
      }
  }

  if (cmdLower !== 'clear') {
    terminalHistory.value.push({ type: 'output', content: output })
  }

  currentCommand.value = ''
  scrollToBottom()
}

defineExpose({ isOpen, togglePanel })
</script>

<style scoped>
.bottom-panel {
  height: 0;
  background-color: var(--vscode-bg);
  display: flex;
  flex-direction: column;
  transition: height 0.2s ease;
  overflow: hidden;
  position: relative;
  z-index: 10;
  border-top: none;
}

.bottom-panel.is-open {
  height: 280px;
  border-top: 1px solid var(--vscode-border);
}

.panel-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 35px;
  min-height: 35px;
  cursor: pointer;
  padding: 0 15px;
  background-color: var(--vscode-bg);
  border-bottom: 1px solid var(--vscode-border);
}

.panel-tabs {
  display: flex;
  gap: 20px;
}

.panel-tab {
  font-size: 11px;
  color: var(--vscode-text-muted);
  letter-spacing: 0.5px;
}

.panel-tab.active {
  color: var(--vscode-text);
  border-bottom: 1px solid var(--theme-accent);
}

.panel-actions {
  display: flex;
  gap: 15px;
  color: var(--vscode-text-muted);
}

.action-icon:hover {
  color: var(--vscode-text);
}

.panel-content {
  padding: 10px 20px;
  flex: 1;
  overflow-y: auto;
  font-family: 'Consolas', monospace;
  font-size: 13px;
  background-color: #1a1a1a;
  cursor: text;
}

.term-path {
  color: #78dce8;
  font-weight: bold;
}

.term-branch {
  color: #ff6188;
}

.term-x {
  color: #a9dc76;
  font-weight: bold;
}

.term-prompt {
  color: #a9dc76;
  margin-right: 8px;
}

.term-text {
  color: var(--vscode-text);
}

:deep(.link) {
  color: #78dce8;
  text-decoration: none;
}

:deep(.link:hover) {
  text-decoration: underline;
  color: #ff6188;
}

:deep(.success) {
  color: #a9dc76;
  font-weight: bold;
}

:deep(.info) {
  color: var(--vscode-text-muted);
}

:deep(.text) {
  color: var(--vscode-text);
}

:deep(.term-path) {
  color: #78dce8;
  font-weight: bold;
}

.mt-2 {
  margin-top: 10px;
}

.terminal-history {
  margin-bottom: 10px;
  line-height: 1.5;
}

.terminal-output {
  margin-top: 5px;
  margin-bottom: 15px;
  line-height: 1.5;
}

.term-input {
  background: transparent;
  border: none;
  color: var(--vscode-text);
  font-family: inherit;
  font-size: inherit;
  outline: none;
  width: 80%;
}

.term-input:disabled {
  opacity: 0.5;
}
</style>