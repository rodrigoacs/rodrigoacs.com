import './assets/main.css'

import { createApp } from 'vue'
import { createI18n } from 'vue-i18n'
// Importação CORRETA (sem as chavetas {})
import pt from './locales/pt.js'
import en from './locales/en.js'

import App from './App.vue'
import router from './router'

const i18n = createI18n({
  legacy: false,
  globalInjection: true,
  locale: getUserLocale(),
  fallbackLocale: 'en',
  messages: {
    pt,
    en
  }
})

const app = createApp(App)

function getUserLocale() {
  const userLang = navigator.language || navigator.userLanguage
  return userLang.split('-')[0]
}

app.use(router)
app.use(i18n)
app.mount('#app')