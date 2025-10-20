<template>
  <nav>
    <div>
      <RouterLink
        class="link"
        :class="{ active: isActive('/') }"
        to="/"
      >
        home
      </RouterLink>

      <RouterLink
        class="link"
        :class="{ active: isActive('/blog') }"
        to="/blog"
      >
        blog
      </RouterLink>

      <RouterLink
        class="link"
        :class="{ active: isActive('/cv') }"
        to="/cv"
      >
        cv
      </RouterLink>
    </div>

    <div class="theme-language-wrapper">
      <button
        @click="toggleLanguage"
        class="language-toggle"
        aria-label="Mudar idioma"
      >
        <img
          v-if="locale === 'pt'"
          src="../assets/images/flag-usa.webp"
          alt="Switch to English"
          class="language-icon"
        />
        <img
          v-else
          src="../assets/images/flag-brazil.webp"
          alt="Mudar para Português"
          class="language-icon"
        />
      </button>

      <button
        @click="changeTheme"
        class="theme-toggle"
        aria-label="Mudar tema"
      >
        <img
          v-if="theme === 'light'"
          src="../assets/images/icons8-night-94.webp"
          alt="Lua"
          class="theme-icon"
        />
        <img
          v-else
          src="../assets/images/icons8-partly-cloudy-day-94.webp"
          alt="Sol"
          class="theme-icon"
        />
      </button>
    </div>
  </nav>
</template>

<script setup>
import { useI18n } from 'vue-i18n'
import { useRoute } from 'vue-router'
import { computed } from 'vue'
import { useTheme } from '../composables/useTheme'

const route = useRoute()
const { locale } = useI18n()
const { theme, toggleTheme } = useTheme()

const locales = computed(() => useI18n().availableLocales)

function changeTheme() {
  toggleTheme()
}

function toggleLanguage() {
  locale.value = locale.value === 'pt' ? 'en' : 'pt'
}

function defaultLanguage() {
  const userLang = (navigator.language || navigator.userLanguage).split('-')[0]
  if (locales.value.includes(userLang)) {
    locale.value = userLang
  }
}

function isActive(path) {
  return route.path === path
}

defaultLanguage()
</script>

<style scoped>
.theme-language-wrapper {
  display: flex;
  align-items: center;
  gap: 12px;
}

.language-toggle,
.theme-toggle {
  background: none;
  border: none;
  cursor: pointer;
  padding: 0;
  width: 24px;
  height: 24px;
  line-height: 0;
}

.language-icon,
.theme-icon {
  width: 100%;
  height: 100%;
  object-fit: contain;
  transition: transform 0.2s ease;
}

.language-toggle:hover .language-icon,
.theme-toggle:hover .theme-icon {
  transform: scale(1.15);
}

.link {
  display: inline-block;
  color: var(--color-text-unfocused);
  text-decoration: none;
  font-size: 1rem;
  font-weight: 400;
  width: 4rem;
  transition: all 0.3s;
}

.link:hover {
  color: var(--color-text-primary);
  font-weight: 500;
}

.link:active {
  transform: scale(0.9);
}

.active {
  color: var(--color-text-primary) !important;
  font-weight: 500 !important;
}

nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin: 4rem 0px;
}
</style>