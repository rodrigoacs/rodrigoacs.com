<template>
  <img
    :src="iconUrl"
    class="file-icon-img"
    alt="file-icon"
    @error="handleError"
  />
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  name: {
    type: String,
    default: ''
  },
  type: {
    type: String,
    default: 'file'
  },
  isOpen: {
    type: Boolean,
    default: false
  }
})

function handleError(e) {
  e.target.src = 'https://cdn.jsdelivr.net/gh/miguelsolorio/vscode-symbols@main/src/icons/files/file.svg'
}

const iconUrl = computed(() => {
  const baseUrl = 'https://cdn.jsdelivr.net/gh/miguelsolorio/vscode-symbols@main/src/icons/'

  if (props.type === 'folder') {
    return props.isOpen ? `${baseUrl}folders/folder-open.svg` : `${baseUrl}folders/folder.svg`
  }

  const lowerName = props.name.toLowerCase()

  if (lowerName.endsWith('.ts')) return `${baseUrl}files/ts.svg`
  if (lowerName.endsWith('.js')) return `${baseUrl}files/js.svg`
  if (lowerName.endsWith('.vue')) return `${baseUrl}files/vue.svg`
  if (lowerName.endsWith('.json')) return `${baseUrl}files/brackets-yellow.svg`
  if (lowerName.endsWith('.md')) return `${baseUrl}files/markdown.svg`
  if (lowerName.endsWith('.html')) return `${baseUrl}files/html.svg`
  if (lowerName.endsWith('.css')) return `${baseUrl}files/css.svg`

  return `${baseUrl}files/file.svg`
})
</script>

<style scoped>
.file-icon-img {
  width: 16px;
  height: 16px;
  margin-right: 6px;
  vertical-align: text-bottom;
  user-select: none;
  -webkit-user-drag: none;
}
</style>