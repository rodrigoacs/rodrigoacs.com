<template>
  <div class="vscode-code-block">
    <div class="code-line"><span class="comment">/**</span></div>
    <div class="code-line"><span class="comment"> * Catálogo de projetos pessoais e em desenvolvimento.</span></div>
    <div class="code-line"><span class="comment"> * Dados carregados dinamicamente via src/data/projects.json</span>
    </div>
    <div class="code-line"><span class="comment"> */</span></div>

    <div class="code-line">
      <span class="keyword">import</span> <span class="text">{</span> <span class="type">Project</span> <span
        class="text"
      >}</span> <span class="keyword">from</span> <span class="string">'@/types/portfolio'</span><span
        class="text">;</span>
    </div>
    <br />

    <div class="code-line">
      <span class="keyword">export const</span> <span class="var">recentProjects</span><span class="text">: </span><span
        class="type"
      >Project</span><span class="text">[] = [</span>
    </div>

    <template
      v-for="(project, index) in projects"
      :key="index"
    >

      <div class="code-line pl-1 codelens-row">
        <span
          class="codelens"
          @click="openPreview(project.name, project.previewUrl)"
        >▶ Preview Project</span>
        <span class="codelens-separator">|</span>
        <a
          :href="project.repoUrl"
          target="_blank"
          class="codelens"
        >🔗 Repository</a>
      </div>

      <div class="code-line pl-1"><span class="text">{</span></div>
      <div class="code-line pl-2"><span class="property">name</span><span class="text">: </span><span class="string">'{{
        project.name }}'</span><span class="text">,</span></div>
      <div class="code-line pl-2"><span class="property">description</span><span class="text">: </span><span
          class="string"
        >'{{ project.description }}'</span><span class="text">,</span></div>

      <div class="code-line pl-2">
        <span class="property">stack</span><span class="text">: [</span>
        <template
          v-for="(tech, tIndex) in project.stack"
          :key="tIndex"
        >
          <span class="string">'{{ tech }}'</span><span class="text">{{ tIndex <
            project.stack.length
            -
            1
            ? ', '
            : ''
              }}</span
            >
        </template>
        <span class="text">]</span>
      </div>

      <div class="code-line pl-1"><span class="text">}{{ index <
        projects.length
        -
        1
        ? ','
        : ''
            }}</span
          >
      </div>

    </template>

    <div class="code-line"><span class="text">];</span><span class="cursor"></span></div>
  </div>
</template>

<script setup>
import { usePreview } from '@/composables/usePreview'
import projectsData from '@/data/projects.json'

const { openPreview } = usePreview()
const projects = projectsData
</script>

<style scoped>
.vscode-code-block {
  font-size: var(--editor-font-size, 14px);
}

.pl-1 {
  padding-left: 2rem !important;
}

.pl-2 {
  padding-left: 3.5rem !important;
}

.code-line {
  margin-bottom: 0;
  white-space: pre-wrap;
  padding: 0 10px;
  border: 1px solid transparent;
  transition: background-color 0.1s;
}

.code-line:hover {
  background-color: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.codelens-row {
  padding-top: 12px;
}

.codelens-row:hover {
  background-color: transparent !important;
  border-color: transparent !important;
}

.codelens {
  font-size: 11px;
  color: var(--vscode-text-muted);
  cursor: pointer;
  user-select: none;
  text-decoration: none;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.codelens:hover {
  color: var(--vscode-text);
}

.codelens-separator {
  color: var(--vscode-border);
  margin: 0 8px;
  font-size: 11px;
}

.keyword {
  color: var(--syntax-keyword);
  font-style: italic;
}

.type {
  color: var(--syntax-class);
  font-style: italic;
}

.var {
  color: var(--syntax-var);
}

.property {
  color: var(--syntax-property);
}

.string {
  color: var(--syntax-string);
}

.comment {
  color: var(--syntax-comment);
}

.text {
  color: var(--vscode-text);
}

.cursor {
  display: inline-block;
  width: 8px;
  height: 1.2em;
  background-color: var(--theme-accent);
  vertical-align: text-bottom;
  animation: blink 1s step-end infinite;
  margin-left: 4px;
}

@keyframes blink {

  0%,
  100% {
    opacity: 1;
  }

  50% {
    opacity: 0;
  }
}
</style>