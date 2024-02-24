<template>
  <main>
    <Bio />

    <Projects />
  </main>
</template>

<script setup>
import Bio from '@/components/Bio.vue'
import Projects from '@/components/Projects.vue'

import { onMounted } from 'vue'

import { generateGithubStatsUrl } from '../composables/githubCard'

onMounted(() => {
  changeProjectCardTheme()
})

function changeProjectCardTheme() {
  const projectsCards = document.querySelectorAll('.project-card')

  projectsCards.forEach(card => {
    document.documentElement.classList.contains('dark')
      ? card.src = generateGithubStatsUrl(card.name, 'dark')
      : card.src = generateGithubStatsUrl(card.name, 'light')
  })
}


</script>

<style scoped>
h2 {
  margin-bottom: 0.8rem;
}

p {
  margin-bottom: 0.8rem;
}
</style>
