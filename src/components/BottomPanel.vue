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

      <div class="terminal-line mt-2">
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
          spellcheck="false"
          autocomplete="off"
        />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, nextTick } from 'vue'

const isOpen = ref(false)
const termInput = ref(null)
const currentCommand = ref('')

const terminalHistory = ref([
  { type: 'output', content: '<span class="info">Portfolio Terminal v1.0.0</span><br><span class="info">Digite <span class="success">help</span> para ver os comandos disponíveis.</span>' }
])

function togglePanel() {
  isOpen.value = !isOpen.value
  if (isOpen.value) focusInput()
}

function closePanel() {
  isOpen.value = false
}

function focusInput() {
  nextTick(() => {
    termInput.value?.focus()
  })
}

function executeCommand() {
  const cmd = currentCommand.value.trim().toLowerCase()
  if (!cmd) return

  terminalHistory.value.push({ type: 'command', content: currentCommand.value })

  let output = ''
  switch (cmd) {
    case 'help':
      output = `
        <span class="success">Comandos disponíveis:</span><br>
        &nbsp;&nbsp;<span class="term-path">help</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mostra esta lista<br>
        &nbsp;&nbsp;<span class="term-path">contact</span>&nbsp;&nbsp;&nbsp;Mostra minhas redes e e-mail<br>
        &nbsp;&nbsp;<span class="term-path">clear</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Limpa o terminal<br>
        &nbsp;&nbsp;<span class="term-path">whoami</span>&nbsp;&nbsp;&nbsp;&nbsp;Um pouco sobre mim<br>
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
      output = `<span class="info">Rodrigo Augusto Correa Soares - Fullstack Developer focado em Node.js e Java. Amante de Magic: The Gathering e Impressão 3D.</span>`
      break
    case 'clear':
      terminalHistory.value = []
      break
    case 'sudo':
      output = `<span style="color: #ff6188;">bash: sudo: permissão negada. Nice try, hacker. ;)</span>`
      break
    default:
      output = `<span style="color: #ff6188;">bash: comando não encontrado: ${cmd}</span><br><span class="info">Digite 'help' para comandos válidos.</span>`
  }

  if (cmd !== 'clear') {
    terminalHistory.value.push({ type: 'output', content: output })
  }

  currentCommand.value = ''
  nextTick(() => {
    const contentDiv = document.querySelector('.panel-content')
    contentDiv.scrollTop = contentDiv.scrollHeight
  })
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
  height: 250px;
  border-top: 1px solid var(--vscode-border);
}

.panel-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 35px;
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
</style>