<template>
  <div class="vscode-code-block">
    <div class="code-line"><span class="comment">// Error: 404 Not Found</span></div>
    <div class="code-line">
      <span class="keyword">import</span> <span class="text">{</span> <span class="type">Page</span> <span
        class="text">}</span> <span class="keyword">from</span> <span class="string error-squiggle">'@/views{{
          route.path }}'</span><span class="text">;</span>
    </div>
    <br>
    <div class="code-line">
      <span class="error-text">Cannot find module '@/views{{ route.path }}' or its corresponding type
        declarations.</span>
    </div>
    <br>
    <div class="code-line"><span class="comment">// Dica: Volte para um diretório seguro</span></div>
    <div class="code-line">
      <span class="keyword">return</span> <span class="property">router</span><span class="text">.</span><span
        class="property"
      >push</span><span class="text">(</span>
      <RouterLink
        to="/"
        class="string link-home"
      >'/'</RouterLink>
      <span class="text">);</span>
      <span class="cursor"></span>
    </div>
  </div>
</template>

<script setup>
import { useRoute } from 'vue-router'

const route = useRoute()
</script>

<style scoped>
.vscode-code-block {
  font-size: 14px;
}

.code-line {
  margin-bottom: 0;
  white-space: pre-wrap;
  padding: 0 10px;
  border: 1px solid transparent;
  transition: background-color 0.1s;
  line-height: 1.6;
}

.code-line:hover {
  background-color: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.comment {
  color: var(--syntax-comment);
}

.keyword {
  color: var(--syntax-keyword);
  font-style: italic;
}

.type {
  color: var(--syntax-class);
  font-style: italic;
}

.string {
  color: var(--syntax-string);
}

.text {
  color: var(--vscode-text);
}

.property {
  color: var(--syntax-property);
}

.error-squiggle {
  text-decoration: underline wavy #ff6188;
  text-underline-offset: 3px;
}

.error-text {
  color: #ff6188;
  font-weight: bold;
}

.link-home {
  text-decoration: underline dashed;
  cursor: pointer;
  transition: color 0.2s;
}

.link-home:hover {
  color: var(--theme-accent);
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