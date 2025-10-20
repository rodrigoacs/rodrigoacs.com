<template>
  <div class="project-card">
    <a
      :href="project.liveUrl"
      target="_blank"
      rel="noopener noreferrer"
      class="card-image-link"
    >
      <img
        :src="project.imageUrl"
        :alt="$t(project.titleKey)"
        class="card-image"
      />
    </a>

    <div class="card-content">
      <h3>
        <a
          :href="project.liveUrl"
          target="_blank"
          rel="noopener noreferrer"
        >
          {{ $t(project.titleKey) }}
        </a>
      </h3>

      <p>{{ $t(project.descriptionKey) }}</p>

      <ul class="tech-stack">
        <li
          v-for="item in techStackWithColors"
          :key="item.name"
          :style="{
            backgroundColor: item.color.bg,
            color: item.color.text,
            borderColor: item.color.border,
          }"
        >
          {{ item.name }}
        </li>
      </ul>

      <div class="card-links">
        <a
          :href="project.liveUrl"
          target="_blank"
          rel="noopener noreferrer"
        >
          {{ $t('projects.links.live') }}
        </a>
        <a
          :href="project.repoUrl"
          target="_blank"
          rel="noopener noreferrer"
        >
          {{ $t('projects.links.repo') }}
        </a>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  project: {
    type: Object,
    required: true,
  },
})

const colorPalette = [
  {
    text: 'var(--tag-red-text-light)',
    bg: 'var(--tag-red-bg-light)',
  },
  {
    text: 'var(--tag-green-text-light)',
    bg: 'var(--tag-green-bg-light)',
  },
  {
    text: 'var(--tag-blue-text-light)',
    bg: 'var(--tag-blue-bg-light)',
  },
  {
    text: 'var(--tag-purple-text-light)',
    bg: 'var(--tag-purple-bg-light)',
  },
  {
    text: 'var(--tag-yellow-text-light)',
    bg: 'var(--tag-yellow-bg-light)',
  },
  {
    text: 'var(--tag-orange-text-light)',
    bg: 'var(--tag-orange-bg-light)',
  },
]

function shuffle(array) {
  let currentIndex = array.length,
    randomIndex
  while (currentIndex !== 0) {
    randomIndex = Math.floor(Math.random() * currentIndex)
    currentIndex--
      ;[array[currentIndex], array[randomIndex]] = [
        array[randomIndex],
        array[currentIndex],
      ]
  }
  return array
}

const shuffledPalette = shuffle([...colorPalette])

const titleColor = computed(() => shuffledPalette[0].text)

const techStackWithColors = computed(() => {
  return props.project.techStack.map((techName, index) => {
    const color = shuffledPalette[index % shuffledPalette.length]
    return {
      name: techName,
      color: {
        text: color.text,
        bg: color.bg,
        border: color.text,
      },
    }
  })
})
</script>

<style scoped>
.project-card {
  background-color: transparent;
  border-radius: 12px;
  padding: 0.5rem;
  margin: -0.5rem;
  transition: background-color 0.3s ease;
  display: flex;
  flex-direction: column;
}

.project-card:hover {
  background-color: var(--color-hover);
}

.project-card a {
  text-decoration: none;
}

.card-image {
  width: 100%;
  aspect-ratio: 16 / 9;
  object-fit: cover;
  border-radius: 8px;
  border: 1px solid var(--color-hover);
  display: block;
}

.card-image-link {
  display: block;
  transition: transform 0.3s ease;
}

.project-card:hover .card-image-link {
  transform: translateY(-4px);
}

.card-content {
  padding-top: 1rem;
  display: flex;
  flex-direction: column;
  flex-grow: 1;
}

.card-content h3 {
  margin-bottom: 0.5rem;
}

.card-content h3 a {
  font-weight: 600;
  color: var(--color-text-primary);
  font-size: 1.1rem;
  transition: color 0.3s ease;
}

.card-content p {
  color: var(--color-text-secondary);
  font-size: 0.9rem;
  line-height: 1.6;
  margin-bottom: 1rem;
  flex-grow: 1;
}

.tech-stack {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
  list-style: none;
  margin-bottom: 1rem;
}

.tech-stack li {
  font-size: 0.75rem;
  font-weight: 600;
  padding: 0.2rem 0.7rem;
  border-radius: 12px;
  border: 1px solid;
}

.card-links {
  display: flex;
  gap: 1.25rem;
  align-items: center;
  margin-top: auto;
}

.card-links a {
  color: var(--color-text-highlight);
  font-weight: 500;
  text-decoration: none;
  font-size: 0.9rem;
  transition: text-decoration 0.2s;
}

.card-links a:hover {
  text-decoration: underline;
}
</style>