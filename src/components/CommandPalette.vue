<template>
  <div
    v-if="isOpen"
    class="palette-overlay"
    @click.self="close"
  >
    <div class="palette-container">
      <input
        ref="searchInput"
        type="text"
        v-model="searchQuery"
        placeholder="Type a command or go to file..."
        @keydown.down.prevent="selectNext"
        @keydown.up.prevent="selectPrev"
        @keydown.enter.prevent="executeSelected"
        @keydown.esc="close"
      >
      <div class="results">
        <div
          v-for="(cmd, index) in filteredCommands"
          :key="cmd.id"
          class="result-item"
          :class="{ selected: index === selectedIndex }"
          @mouseenter="selectedIndex = index"
          @click="executeSelected"
        >
          <span class="cmd-icon">{{ cmd.icon }}</span>
          <span class="cmd-name">{{ cmd.name }}</span>
          <span
            class="cmd-shortcut"
            v-if="cmd.shortcut"
          >{{ cmd.shortcut }}</span>
        </div>
        <div
          v-if="filteredCommands.length === 0"
          class="no-results"
        >
          No commands matching
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, nextTick, watch } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const emit = defineEmits(['toggle-panel'])

const isOpen = ref(false)
const searchQuery = ref('')
const searchInput = ref(null)
const selectedIndex = ref(0)

const commands = [
  { id: 1, name: 'File: Go to Home.ts', icon: '📘', action: () => router.push('/') },
  { id: 2, name: 'File: Go to Projects.ts', icon: '📁', action: () => router.push('/projects') },
  { id: 3, name: 'File: Go to Blog.md', icon: '📝', action: () => router.push('/blog') },
  { id: 4, name: 'File: Go to CV.json', icon: '{}', action: () => router.push('/cv') },
  { id: 5, name: 'View: Toggle Terminal', icon: '💻', shortcut: 'Ctrl+`', action: () => emit('toggle-panel') },
  { id: 6, name: 'System: Download CV PDF', icon: '⬇️', action: () => window.open('https://librishelf.com/download/cv_RodrigoSoares.pdf', '_blank') }
]

const filteredCommands = computed(() => {
  if (!searchQuery.value) return commands
  const query = searchQuery.value.toLowerCase()
  return commands.filter(cmd => cmd.name.toLowerCase().includes(query))
})

watch(searchQuery, () => {
  selectedIndex.value = 0
})

function open() {
  isOpen.value = true
  searchQuery.value = ''
  selectedIndex.value = 0
  nextTick(() => {
    searchInput.value?.focus()
  })
}

function close() {
  isOpen.value = false
}

function selectNext() {
  if (selectedIndex.value < filteredCommands.value.length - 1) {
    selectedIndex.value++
  }
}

function selectPrev() {
  if (selectedIndex.value > 0) {
    selectedIndex.value--
  }
}

function executeSelected() {
  const cmd = filteredCommands.value[selectedIndex.value]
  if (cmd) {
    cmd.action()
    close()
  }
}

defineExpose({ open, close, isOpen })
</script>

<style scoped>
.palette-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.4);
  z-index: 9999;
  display: flex;
  justify-content: center;
  align-items: flex-start;
  padding-top: 50px;
}

.palette-container {
  width: 600px;
  background-color: var(--vscode-sidebar-bg);
  border: 1px solid var(--vscode-border);
  border-radius: 6px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

input {
  background-color: var(--vscode-bg);
  color: var(--vscode-text);
  border: none;
  border-bottom: 1px solid var(--vscode-border);
  padding: 12px 15px;
  font-family: inherit;
  font-size: 14px;
  outline: none;
}

input:focus {
  border-bottom: 1px solid var(--theme-accent);
}

.results {
  max-height: 300px;
  overflow-y: auto;
  padding: 5px;
}

.result-item {
  display: flex;
  align-items: center;
  padding: 8px 10px;
  cursor: pointer;
  border-radius: 4px;
  color: var(--vscode-text);
}

.result-item.selected,
.result-item:hover {
  background-color: var(--vscode-selection);
  color: #fff;
}

.cmd-icon {
  margin-right: 10px;
  width: 20px;
  text-align: center;
}

.cmd-name {
  flex: 1;
}

.cmd-shortcut {
  font-size: 11px;
  color: var(--vscode-text-muted);
  background: var(--vscode-bg);
  padding: 2px 6px;
  border-radius: 3px;
}

.no-results {
  padding: 15px;
  text-align: center;
  color: var(--vscode-text-muted);
  font-style: italic;
}
</style>