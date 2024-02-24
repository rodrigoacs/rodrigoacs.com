import './assets/main.css'

import { createApp } from 'vue'
import { createI18n } from 'vue-i18n'
import { pt } from './locales/pt.js'
import { en } from './locales/en.js'

import App from './App.vue'
import router from './router'

const languages = {
  pt,
  en,
}

const i18n = createI18n({
  legacy: false,
  locale: getUserLocale(),
  fallbackLocale: 'en',
  messages: languages,
})

const app = createApp(App)

function getUserLocale() {
  const userLang = navigator.language || navigator.userLanguage
  return userLang.split('-')[0]
}

app.use(router)
app.use(i18n)
app.mount('#app')
