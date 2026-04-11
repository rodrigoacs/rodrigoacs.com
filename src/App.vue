<template>
  <div class="vscode-app">

    <CommandPalette
      ref="commandPalette"
      @toggle-panel="toggleTerminal"
    />

    <div class="vscode-body">
      <div class="vscode-activity-bar">
        <div
          class="activity-icon active"
          title="Explorer"
        >📄</div>
        <div
          class="activity-icon"
          title="Search"
        >🔍</div>
        <div
          class="activity-icon"
          title="Source Control"
        >⎇</div>
        <div
          class="activity-icon bottom"
          title="Manage"
          @click="openCommandPalette"
        >⚙️</div>
      </div>

      <div class="vscode-sidebar">
        <div class="sidebar-title">EXPLORER</div>
        <Navigation />
      </div>

      <div class="vscode-main">

        <div class="editor-tabs">
          <div class="tab active">
            <span class="file-icon">{{ currentFileIcon }}</span>
            <span class="tab-name">{{ currentFileName }}</span>
            <span class="close-icon">x</span>
          </div>
        </div>

        <div class="editor-breadcrumbs">
          rodrigoacs-portfolio > src > views > {{ currentFileName }}
        </div>

        <div class="editor-content-area">
          <div class="line-numbers">
            <div
              v-for="n in 50"
              :key="n"
              class="line-number"
            >{{ n }}</div>
          </div>
          <div class="code-content">
            <RouterView />
          </div>
        </div>

        <BottomPanel ref="bottomPanel" />

      </div>
    </div>

    <FooterVue />
  </div>
</template>

<script setup>
import { computed, ref, onMounted, onUnmounted } from 'vue'
import { useRoute } from 'vue-router'
import Navigation from '@/components/Navigation.vue'
import FooterVue from '@/components/Footer.vue'
import BottomPanel from '@/components/BottomPanel.vue'
import CommandPalette from '@/components/CommandPalette.vue'

const route = useRoute()

const bottomPanel = ref(null)
const commandPalette = ref(null)

const currentFileName = computed(() => {
  switch (route.path) {
    case '/': return 'Home.ts'
    case '/projects': return 'Projects.ts'
    case '/blog': return 'Blog.md'
    case '/cv': return 'CV.json'
    default: return '404.txt'
  }
})

const currentFileIcon = computed(() => {
  switch (route.path) {
    case '/': return '📘'
    case '/projects': return '📁'
    case '/blog': return '📝'
    case '/cv': return '{}'
    default: return '📄'
  }
})

function openCommandPalette() {
  commandPalette.value?.open()
}

function toggleTerminal() {
  bottomPanel.value?.togglePanel()
}

function handleKeydown(e) {
  // Command Palette: Ctrl+Shift+P ou Cmd+Shift+P
  if ((e.ctrlKey || e.metaKey) && e.shiftKey && e.key.toLowerCase() === 'p') {
    e.preventDefault()
    openCommandPalette()
  }

  // Terminal: Ctrl+` (Crase) ou Ctrl+' (Aspas Simples para ABNT2)
  if ((e.ctrlKey || e.metaKey) && (e.key === '`' || e.key === "'")) {
    e.preventDefault()
    toggleTerminal()
  }
}

onMounted(() => {
  window.addEventListener('keydown', handleKeydown)
})

onUnmounted(() => {
  window.removeEventListener('keydown', handleKeydown)
})
</script>

<style scoped>
.vscode-app {
  display: flex;
  flex-direction: column;
  height: 100vh;
  width: 100vw;
}

.vscode-body {
  display: flex;
  flex: 1;
  overflow: hidden;
}

/* Activity Bar */
.vscode-activity-bar {
  width: 50px;
  background-color: var(--vscode-activity-bg);
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-top: 10px;
}

.activity-icon {
  font-size: 1.5rem;
  padding: 10px 0;
  cursor: pointer;
  opacity: 0.5;
  width: 100%;
  text-align: center;
  transition: opacity 0.2s;
}

.activity-icon:hover {
  opacity: 1;
}

.activity-icon.active {
  opacity: 1;
  border-left: 2px solid var(--theme-accent);
}

.activity-icon.bottom {
  margin-top: auto;
  margin-bottom: 10px;
}

/* Side Bar */
.vscode-sidebar {
  width: 250px;
  background-color: var(--vscode-sidebar-bg);
  border-right: 1px solid var(--vscode-border);
  display: flex;
  flex-direction: column;
}

.sidebar-title {
  font-size: 0.75rem;
  padding: 10px 20px;
  color: var(--vscode-text-muted);
}

/* Main Editor */
.vscode-main {
  flex: 1;
  display: flex;
  flex-direction: column;
  background-color: var(--vscode-bg);
  overflow: hidden;
  position: relative;
}

/* Tabs */
.editor-tabs {
  display: flex;
  background-color: var(--vscode-sidebar-bg);
  height: 35px;
  overflow-x: auto;
}

.editor-tabs::-webkit-scrollbar {
  height: 0;
}

.tab {
  display: flex;
  align-items: center;
  padding: 0 10px 0 15px;
  background-color: var(--vscode-tab-inactive);
  color: var(--vscode-text-muted);
  border-right: 1px solid var(--vscode-border);
  cursor: pointer;
  min-width: 150px;
  position: relative;
}

.tab.active {
  background-color: var(--vscode-tab-active);
  color: var(--vscode-text);
  border-top: 2px solid var(--theme-accent);
}

.tab-name {
  flex: 1;
  margin-right: 10px;
}

.file-icon {
  margin-right: 5px;
  font-size: 0.9rem;
}

.close-icon {
  width: 18px;
  height: 18px;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 4px;
  font-size: 12px;
  opacity: 0;
  transition: opacity 0.2s, background-color 0.2s;
}

.tab:hover .close-icon {
  opacity: 1;
}

.close-icon:hover {
  background-color: rgba(255, 255, 255, 0.1);
}

/* Breadcrumbs & Content */
.editor-breadcrumbs {
  padding: 5px 15px;
  font-size: 0.85rem;
  color: var(--vscode-text-muted);
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
}

.editor-content-area {
  display: flex;
  flex: 1;
  overflow: auto;
  padding-top: 10px;
}

.line-numbers {
  padding: 0 15px 0 20px;
  text-align: right;
  color: var(--vscode-text-muted);
  user-select: none;
  font-size: 14px;
  line-height: 1.6;
}

.code-content {
  flex: 1;
  padding-right: 20px;
  padding-bottom: 50px;
  line-height: 1.6;
  overflow-x: auto;
}
</style>