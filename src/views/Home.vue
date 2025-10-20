<template>
  <main>
    <Bio />
    <Skills />
    <Projects />
  </main>
</template>

<script setup>
import Bio from '@/components/Bio.vue'
import Skills from '@/components/Skills.vue' // << ADICIONE ESTA LINHA
import Projects from '@/components/Projects.vue'
</script>

<style scoped>
h2 {
  margin-bottom: 0.8rem;
}

p {
  margin-bottom: 0.8rem;
}
</style>