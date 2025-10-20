<template>
  <section class="skills-section">
    <h2>{{ $t('cv.skills') }}</h2>

    <div class="skills-grid">
      <div
        v-for="skill in skills"
        :key="skill.name"
        class="skill-item"
      >
        <img
          :src="skill.icon"
          :alt="skill.name"
          class="skill-icon"
        />
        <span class="skill-name">{{ skill.name }}</span>
      </div>
    </div>
  </section>
</template>

<script setup>
import { skills } from '../data/skills.js'
</script>

<style scoped>
.skills-section {
  padding-block: 2rem;
  border-bottom: 1px solid var(--color-hover);
}

h2 {
  text-align: center;
  font-weight: 600;
  color: var(--color-text-primary);
  margin-bottom: 2rem;
}

.skills-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
  gap: 1.5rem;
}

.skill-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 1rem;
  background-color: transparent;
  border-radius: 8px;
  transition: all 0.2s ease-out;
}

.skill-item:hover {
  background-color: var(--color-hover);
  transform: translateY(-5px);
}

.skill-icon {
  width: 48px;
  height: 48px;
  margin-bottom: 0.75rem;
}

.skill-name {
  font-size: 0.875rem;
  font-weight: 500;
  color: var(--color-text-secondary);
}
</style>