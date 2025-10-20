<template>
  <div>
    <h2>
      {{ $t("projects.title") }}
    </h2>

    <div class="projects-grid">
      <ProjectCard
        v-for="project in projects"
        :key="project.id"
        :project="project"
      />
    </div>
  </div>
</template>

<script setup>
import { projects } from '../data/projects.js'
import ProjectCard from './ProjectCard.vue'
</script>

<style scoped>
h2 {
  margin-top: 1.6rem;
  margin-bottom: 1.2rem;
  font-weight: 600;
}

.projects-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 2.5rem;
}

@media screen and (min-width: 768px) {
  .projects-grid {
    grid-template-columns: 1fr 1fr;
    gap: 2rem;
  }
}
</style>