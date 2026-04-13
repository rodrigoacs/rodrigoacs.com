<template>
  <div class="vscode-code-block">
    <div class="code-line"><span class="comment">/**</span></div>
    <div class="code-line"><span class="comment"> * {{ t("blog.title") }}</span></div>
    <div class="code-line"><span class="comment"> */</span></div>

    <div class="code-line">
      <span class="keyword">import</span> <span class="text">{</span> <span class="type">Post</span> <span
        class="text">}</span> <span class="keyword">from</span> <span class="string">'@/types/blog'</span><span
        class="text"
      >;</span>
    </div>
    <br />

    <div class="code-line">
      <span class="keyword">export const</span> <span class="var">blogPosts</span><span class="text">: </span><span
        class="type"
      >Post</span><span class="text">[] = [</span>
    </div>

    <div class="code-line pl-1"><span class="comment">// Em breve, novos artigos sobre Node.js, Java e Magic...</span>
    </div>
    <div class="code-line"><span class="text">];</span><span class="cursor"></span></div>
  </div>
</template>

<script setup>
import { useI18n } from 'vue-i18n'
const { t } = useI18n()
</script>

<style scoped>
.vscode-code-block {
  font-size: var(--editor-font-size, 14px);
}

.pl-1 {
  padding-left: 2rem !important;
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