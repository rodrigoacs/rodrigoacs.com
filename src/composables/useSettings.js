import { ref } from 'vue'

const globalSettings = ref({
  "editor.fontSize": 14,
  "workbench.colorTheme": "Monokai Spectrum"
})

const isMatrixActive = ref(false)

export function useSettings() {
  function toggleMatrix() {
    isMatrixActive.value = !isMatrixActive.value
  }

  return {
    globalSettings,
    isMatrixActive,
    toggleMatrix
  }
}