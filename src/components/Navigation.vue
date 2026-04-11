<template>
  <div class="explorer-content">
    <div class="folder">
      <div
        class="folder-header"
        @click="isOpen = !isOpen"
      >
        <span class="chevron">{{ isOpen ? '∨' : '>' }}</span>
        <FileIcon
          type="folder"
          :isOpen="isOpen"
        />
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
          <FileIcon name="Home.ts" /> Home.ts
        </RouterLink>

        <RouterLink
          class="file-link"
          to="/projects"
          active-class="active"
        >
          <FileIcon name="Projects.ts" /> Projects.ts
        </RouterLink>

        <RouterLink
          class="file-link"
          to="/blog"
          active-class="active"
        >
          <FileIcon name="Blog.md" /> Blog.md
        </RouterLink>

        <RouterLink
          class="file-link"
          to="/cv"
          active-class="active"
        >
          <FileIcon name="CV.json" /> CV.json
        </RouterLink>

        <RouterLink
          class="file-link"
          to="/settings"
          active-class="active"
        >
          <FileIcon name="settings.json" /> settings.json
        </RouterLink>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import FileIcon from '@/components/FileIcon.vue'

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
  color: var(--vscode-text);
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

.folder-name {
  margin-left: 2px;
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
  color: var(--vscode-text-muted);
  border-left: 1px solid transparent;
  text-decoration: none;
}

.file-link:hover {
  background-color: var(--vscode-hover);
  color: var(--vscode-text);
}

.file-link.active {
  background-color: var(--vscode-selection);
  color: #ffffff;
}
</style>