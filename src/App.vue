<template>
  <div class="vscode-app">
    <div class="vscode-body">

      <div class="vscode-activity-bar">
        <div class="activity-icon active">📄</div>
        <div class="activity-icon">🔍</div>
        <div class="activity-icon">⎇</div>
        <div class="activity-icon bottom">⚙️</div>
      </div>

      <div class="vscode-sidebar">
        <div class="sidebar-title">EXPLORER</div>
        <Navigation />
      </div>

      <div class="vscode-main">
        <div class="editor-tabs">
          <div class="tab active">
            <span class="file-icon">{{ currentFileIcon }}</span> {{ currentFileName }}
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
      </div>
    </div>

    <FooterVue />
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import Navigation from '@/components/Navigation.vue'
import FooterVue from '@/components/Footer.vue'

const route = useRoute()

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
}

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
  padding: 0 15px;
  background-color: var(--vscode-tab-inactive);
  color: var(--vscode-text-muted);
  border-right: 1px solid var(--vscode-border);
  cursor: pointer;
  min-width: 120px;
}

.tab.active {
  background-color: var(--vscode-tab-active);
  color: var(--vscode-text);
  border-top: 2px solid var(--theme-accent);
}

.file-icon {
  margin-right: 5px;
  font-size: 0.9rem;
}

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