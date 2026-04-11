<template>
  <div class="explorer-content">
    <div class="folder">
      <div
        class="folder-header"
        @click="isOpen = !isOpen"
      >
        <span class="chevron">{{ isOpen ? '∨' : '>' }}</span>
        <span class="folder-name">PORTFOLIO</span>
      </div>

      <div
        class="files"
        v-show="isOpen"
      >
        <RouterLink
          class="file-link"
          to="/"
          active-class="active"
        >
          <span class="file-icon">📘</span> Home.ts
        </RouterLink>

        <RouterLink
          class="file-link"
          to="/projects"
          active-class="active"
        >
          <span class="file-icon">📁</span> Projects.ts
        </RouterLink>

        <RouterLink
          class="file-link"
          to="/blog"
          active-class="active"
        >
          <span class="file-icon">📝</span> Blog.md
        </RouterLink>

        <RouterLink
          class="file-link"
          to="/cv"
          active-class="active"
        >
          <span class="file-icon">{}</span> CV.json
        </RouterLink>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const isOpen = ref(true)
</script>

<style scoped>
.explorer-content {
  display: flex;
  flex-direction: column;
  padding-top: 5px;
}

.folder-header {
  display: flex;
  align-items: center;
  padding: 4px 10px;
  cursor: pointer;
  font-weight: bold;
  font-size: 0.85rem;
}

.folder-header:hover {
  background-color: var(--vscode-hover);
}

.chevron {
  margin-right: 5px;
  width: 12px;
  text-align: center;
  color: var(--vscode-text-muted);
}

.files {
  display: flex;
  flex-direction: column;
}

.file-link {
  display: flex;
  align-items: center;
  padding: 4px 10px 4px 25px;
  font-size: 0.9rem;
  color: var(--vscode-text);
  border-left: 2px solid transparent;
}

.file-link:hover {
  background-color: var(--vscode-hover);
}

.file-link.active {
  background-color: var(--vscode-selection);
  color: #ffffff;
}

.file-icon {
  margin-right: 6px;
  font-size: 0.9rem;
}
</style>