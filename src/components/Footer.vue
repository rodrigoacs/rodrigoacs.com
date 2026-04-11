<template>
  <footer class="vscode-status-bar">
    <div class="status-left">
      <span class="status-item remote-icon">><</span>
          <span class="status-item">main*</span>
          <span class="status-item">⊗ 0 ⚠ 0</span>
    </div>

    <div class="status-right">
      <span class="status-item">Ln 15, Col 42</span>
      <span class="status-item">Spaces: 2</span>
      <span class="status-item">UTF-8</span>
      <span class="status-item select-wrapper">
        <select
          @change="changeLanguage($event.target.value)"
          v-model="currentLang"
        >
          <option
            v-for="locale in locales"
            :key="locale"
            :value="locale"
          >
            {{ locale === 'pt' ? 'Português' : 'English' }}
          </option>
        </select>
      </span>
      <span class="status-item">Prettier</span>
    </div>
  </footer>
</template>

<script setup>
import { useI18n } from 'vue-i18n'
import { computed, onMounted, ref } from 'vue'

const { locale } = useI18n()
const currentLang = ref(locale.value)
const locales = computed(() => useI18n().availableLocales)

onMounted(() => {
  const userLang = (navigator.language || navigator.userLanguage).split('-')[0]
  if (locales.value.includes(userLang)) {
    currentLang.value = userLang
    locale.value = userLang
  }
})

function changeLanguage(selectedLocale) {
  locale.value = selectedLocale
}
</script>

<style scoped>
.vscode-status-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: var(--vscode-status-bg);
  color: var(--vscode-status-fg);
  border-top: 1px solid var(--vscode-border);
  height: 22px;
  font-size: 12px;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
}

.status-left,
.status-right {
  display: flex;
  align-items: center;
  height: 100%;
}

.status-item {
  padding: 0 10px;
  display: flex;
  align-items: center;
  height: 100%;
  cursor: pointer;
  transition: background-color 0.1s;
}

.status-item:hover {
  background-color: var(--vscode-hover);
  color: var(--vscode-text);
}

.remote-icon {
  background-color: var(--theme-accent);
  color: #1a1a1a;
  /* Contraste escuro para o texto no botão laranja */
  font-weight: bold;
}

.remote-icon:hover {
  background-color: #e58759;
  /* Laranja ligeiramente mais escuro no hover */
  color: #1a1a1a;
}

.select-wrapper {
  padding: 0;
}

select {
  background-color: transparent;
  color: inherit;
  border: none;
  padding: 0 10px;
  height: 100%;
  font-family: inherit;
  font-size: inherit;
  cursor: pointer;
  appearance: none;
}

select:focus {
  outline: none;
}

option {
  background-color: var(--vscode-bg);
  color: var(--vscode-text);
}
</style>