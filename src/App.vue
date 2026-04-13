<template>
  <div
    class="vscode-app"
    :style="dynamicStyles"
  >
    <div class="vscode-body">
      <div class="vscode-activity-bar">
        <div
          class="activity-icon active"
          :title="$t('nav.explorer')"
        ><i class="codicon codicon-files"></i></div>
      </div>

      <div class="vscode-sidebar">
        <div class="sidebar-title">{{ $t('nav.explorer') }}</div>
        <Navigation />
      </div>

      <div class="vscode-main">
        <div
          class="editor-split-layout"
          :class="{ 'is-dragging': isResizing }"
        >
          <div
            class="editor-pane"
            :style="isPreviewOpen ? { width: leftPaneWidth + '%' } : { flex: 1 }"
          >
            <div class="editor-breadcrumbs">rodrigoacs-portfolio > src > views > {{ currentFileName }}</div>
          </div>

          <div
            class="resizer"
            v-if="isPreviewOpen"
            @mousedown="startResize"
          ></div>

          <div
            class="editor-pane preview-pane"
            v-if="isPreviewOpen"
            :style="{ width: (100 - leftPaneWidth) + '%' }"
          >
            <div class="editor-tabs">
              <div class="tab active">
                <span class="tab-name">{{ $t('nav.browser') }}: {{ previewTitle }}</span>
              </div>
            </div>
          </div>
        </div>
        <BottomPanel ref="bottomPanel" />
      </div>
    </div>
    <FooterVue />
  </div>
</template>

<script setup>
import { computed, ref, onMounted, onUnmounted, watch } from 'vue'
import { useRoute } from 'vue-router'
import Navigation from '@/components/Navigation.vue'
import FooterVue from '@/components/Footer.vue'
import BottomPanel from '@/components/BottomPanel.vue'
import CommandPalette from '@/components/CommandPalette.vue'
import FileIcon from '@/components/FileIcon.vue'
import { usePreview } from '@/composables/usePreview'
import { useSettings } from '@/composables/useSettings'

const route = useRoute()
const bottomPanel = ref(null)
const commandPalette = ref(null)
const iframeKey = ref(0)

const { isPreviewOpen, previewUrl, previewTitle, closePreview } = usePreview()
const { globalSettings, isMatrixActive } = useSettings()

const showSplash = ref(true)
const isFadingSplash = ref(false)

const leftPaneWidth = ref(50)
const isResizing = ref(false)

function startResize(e) {
  isResizing.value = true
  document.addEventListener('mousemove', resize)
  document.addEventListener('mouseup', stopResize)
  document.body.style.userSelect = 'none'
}

function resize(e) {
  if (!isResizing.value) return
  const container = document.querySelector('.editor-split-layout')
  if (!container) return

  const containerRect = container.getBoundingClientRect()
  const newWidth = ((e.clientX - containerRect.left) / containerRect.width) * 100

  if (newWidth > 20 && newWidth < 80) {
    leftPaneWidth.value = newWidth
  }
}

function stopResize() {
  isResizing.value = false
  document.removeEventListener('mousemove', resize)
  document.removeEventListener('mouseup', stopResize)
  document.body.style.userSelect = ''
}

const dynamicStyles = computed(() => {
  const isDracula = globalSettings.value['workbench.colorTheme'] === 'Dracula'
  return {
    '--editor-font-size': `${globalSettings.value['editor.fontSize']}px`,
    '--vscode-bg': isDracula ? '#282a36' : '#222222',
    '--vscode-sidebar-bg': isDracula ? '#21222c' : '#1e1e1e',
    '--vscode-activity-bg': isDracula ? '#191a21' : '#191919',
    '--theme-accent': isDracula ? '#bd93f9' : '#fc9867',
  }
})

const currentFileName = computed(() => {
  switch (route.path) {
    case '/': return 'Home.ts'
    case '/projects': return 'Projects.ts'
    case '/blog': return 'Blog.md'
    case '/cv': return 'CV.json'
    case '/settings': return 'settings.json'
    default: return '404.ts'
  }
})

const previewFaviconUrl = computed(() => {
  if (!previewUrl.value) return ''
  try {
    const url = new URL(previewUrl.value)
    return `https://icons.duckduckgo.com/ip3/${url.hostname}.ico`
  } catch (e) {
    return 'https://cdn.jsdelivr.net/gh/miguelsolorio/vscode-symbols@main/src/icons/files/html.svg'
  }
})

function openCommandPalette() { commandPalette.value?.open() }
function toggleTerminal() { bottomPanel.value?.togglePanel() }

function handleKeydown(e) {
  if ((e.ctrlKey || e.metaKey) && e.shiftKey && e.key.toLowerCase() === 'p') { e.preventDefault(); openCommandPalette() }
  if ((e.ctrlKey || e.metaKey) && (e.key === '`' || e.key === "'")) { e.preventDefault(); toggleTerminal() }
}

const matrixCanvas = ref(null)
let matrixInterval
watch(isMatrixActive, (active) => {
  if (active && matrixCanvas.value) {
    const canvas = matrixCanvas.value
    const ctx = canvas.getContext('2d')
    canvas.width = window.innerWidth; canvas.height = window.innerHeight
    const chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ<>{}[]$'.split('')
    const font_size = 14; const columns = canvas.width / font_size
    const drops = Array(Math.floor(columns)).fill(1)

    matrixInterval = setInterval(() => {
      ctx.fillStyle = 'rgba(0, 0, 0, 0.05)'
      ctx.fillRect(0, 0, canvas.width, canvas.height)
      ctx.fillStyle = '#0F0'
      ctx.font = font_size + 'px monospace'
      for (let i = 0; i < drops.length; i++) {
        const text = chars[Math.floor(Math.random() * chars.length)]
        ctx.fillText(text, i * font_size, drops[i] * font_size)
        if (drops[i] * font_size > canvas.height && Math.random() > 0.975) drops[i] = 0
        drops[i]++
      }
    }, 33)
  } else {
    clearInterval(matrixInterval)
  }
})

onMounted(() => {
  window.addEventListener('keydown', handleKeydown)
  setTimeout(() => {
    isFadingSplash.value = true
    setTimeout(() => showSplash.value = false, 500)
  }, 1200)
})

onUnmounted(() => {
  window.removeEventListener('keydown', handleKeydown)
  document.removeEventListener('mousemove', resize)
  document.removeEventListener('mouseup', stopResize)
})
</script>

<style scoped>
.vscode-app {
  display: flex;
  flex-direction: column;
  height: 100vh;
  width: 100vw;
  transition: background-color 0.3s;
}

.vscode-body {
  display: flex;
  flex: 1;
  overflow: hidden;
}

.splash-screen {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background-color: #1e1e1e;
  z-index: 9999;
  display: flex;
  justify-content: center;
  align-items: center;
  transition: opacity 0.5s ease, visibility 0.5s;
}

.splash-screen.fade-out {
  opacity: 0;
  visibility: hidden;
}

.splash-logo {
  width: 100px;
  height: 100px;
  color: #007acc;
  animation: pulse 1.5s infinite;
}

@keyframes pulse {
  0% {
    opacity: 0.8;
    transform: scale(0.95);
  }

  50% {
    opacity: 1;
    transform: scale(1);
  }

  100% {
    opacity: 0.8;
    transform: scale(0.95);
  }
}

.matrix-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  z-index: 9998;
  pointer-events: none;
  opacity: 0.85;
}

.vscode-activity-bar {
  width: 50px;
  background-color: var(--vscode-activity-bg);
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-top: 10px;
  transition: background-color 0.3s;
}

.activity-icon {
  padding: 12px 0;
  cursor: pointer;
  opacity: 0.5;
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
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

.vscode-sidebar {
  width: 250px;
  background-color: var(--vscode-sidebar-bg);
  border-right: 1px solid var(--vscode-border);
  display: flex;
  flex-direction: column;
  transition: background-color 0.3s;
}

.sidebar-title {
  font-size: 0.75rem;
  padding: 10px 20px;
  color: var(--vscode-text-muted);
}

.vscode-main {
  flex: 1;
  display: flex;
  flex-direction: column;
  background-color: var(--vscode-bg);
  overflow: hidden;
  position: relative;
  transition: background-color 0.3s;
}

.editor-split-layout {
  display: flex;
  flex: 1;
  overflow: hidden;
}

.editor-pane {
  display: flex;
  flex-direction: column;
  min-width: 0;
}

.resizer {
  width: 4px;
  background-color: var(--vscode-bg);
  border-left: 1px solid var(--vscode-border);
  cursor: col-resize;
  z-index: 10;
  transition: background-color 0.2s ease;
}

.resizer:hover,
.resizer.active {
  background-color: var(--theme-accent);
}

.is-dragging .preview-iframe {
  pointer-events: none;
}

.editor-tabs {
  display: flex;
  background-color: var(--vscode-sidebar-bg);
  height: 35px;
  overflow-x: auto;
  transition: background-color 0.3s;
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
  margin-left: 2px;
}

.close-icon {
  width: 20px;
  height: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 4px;
  opacity: 0;
  transition: opacity 0.2s, background-color 0.2s;
}

.tab:hover .close-icon {
  opacity: 1;
}

.close-icon:hover {
  background-color: rgba(255, 255, 255, 0.1);
}

.favicon-img {
  width: 16px;
  height: 16px;
  margin-right: 6px;
  object-fit: contain;
  border-radius: 2px;
}

.editor-breadcrumbs {
  padding: 5px 15px;
  font-size: 0.85rem;
  color: var(--vscode-text-muted);
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
}

.editor-layout-wrapper {
  display: flex;
  flex: 1;
  overflow: hidden;
}

.editor-content-area {
  display: flex;
  flex: 1;
  overflow: auto;
  padding-top: 10px;
  font-size: var(--editor-font-size, 14px);
}

.line-numbers {
  padding: 0 15px 0 20px;
  text-align: right;
  color: var(--vscode-text-muted);
  user-select: none;
  line-height: 1.6;
}

.code-content {
  flex: 1;
  padding-right: 20px;
  padding-bottom: 50px;
  line-height: 1.6;
  overflow-x: auto;
}

.preview-content-area {
  flex: 1;
  display: flex;
  flex-direction: column;
  background-color: var(--vscode-bg);
  transition: background-color 0.3s;
}

.browser-toolbar {
  display: flex;
  align-items: center;
  padding: 8px 15px;
  background-color: var(--vscode-sidebar-bg);
  border-bottom: 1px solid var(--vscode-border);
}

.browser-btn {
  color: var(--vscode-text-muted);
  cursor: pointer;
  margin-right: 15px;
  font-size: 16px;
  font-weight: bold;
}

.browser-btn:hover {
  color: var(--vscode-text);
}

.browser-address-bar {
  flex: 1;
  background-color: var(--vscode-bg);
  border: 1px solid var(--vscode-border);
  color: var(--vscode-text-muted);
  padding: 4px 10px;
  border-radius: 3px;
  font-size: 12px;
  outline: none;
  transition: background-color 0.3s;
}

.preview-iframe {
  flex: 1;
  width: 100%;
  border: none;
  background-color: #ffffff;
}

.splash-favicon-centered {
  width: 128px;
  height: 128px;
  object-fit: contain;
  animation: pulse 1.5s infinite;
}
</style>