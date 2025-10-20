import { watchEffect } from 'vue'
import { useStorage } from '@vueuse/core'

const theme = useStorage('app-theme', 'light')

function toggleTheme() {
  theme.value = theme.value === 'light' ? 'dark' : 'light'
}

watchEffect(() => {
  const root = document.documentElement
  if (theme.value === 'dark') {
    root.classList.add('dark')
    root.classList.remove('light')
  } else {
    root.classList.remove('dark')
    root.classList.add('light')
  }
})

export function useTheme() {
  return {
    theme,
    toggleTheme
  }
}