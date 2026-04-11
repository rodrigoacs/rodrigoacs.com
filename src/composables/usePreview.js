import { ref } from 'vue'

const isPreviewOpen = ref(false)
const previewUrl = ref('')
const previewTitle = ref('')

export function usePreview() {
  function openPreview(title, url) {
    previewTitle.value = title
    previewUrl.value = url
    isPreviewOpen.value = true
  }

  function closePreview() {
    isPreviewOpen.value = false
    previewUrl.value = ''
  }

  return {
    isPreviewOpen,
    previewUrl,
    previewTitle,
    openPreview,
    closePreview
  }
}