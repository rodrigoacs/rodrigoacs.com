<template>
  <div class="vscode-code-block">
    <div class="code-line"><span class="md-heading"># {{ $t("blog.title") }}</span></div>
    <div class="code-line"></div>
    <div class="code-line"><span class="md-quote">> Meus artigos, tutoriais e devaneios sobre desenvolvimento fullstack,
        impressão 3D e tecnologia.</span></div>
    <div class="code-line"></div>
    <div class="code-line"><span class="md-hr">---</span></div>
    <div class="code-line"></div>

    <!-- <div class="code-line">
      <span class="md-heading">## </span><a
        href="#"
        class="md-link"
      >[to-do]</a><span class="md-url">(to-do)</span>
    </div>
    <div class="code-line">
      <span class="md-bold">**00 Out 0000**</span> <span class="text">|</span> <span class="md-italic">*Backend,
        Node.js, Architecture*</span>
    </div>
    <div class="code-line">
      <span class="text">...</span>
    </div> -->
    <div class="code-line"></div>
    <div class="code-line"><span class="md-hr">---</span></div>
    <div class="code-line"></div>
    <div class="code-line"><span class="cursor"></span></div>
  </div>
</template>

<style scoped>
.vscode-code-block {
  font-size: var(--editor-font-size, 14px);
}

/* Destaque da Linha Ativa */
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

/* Destaque de Sintaxe - Markdown Monokai */
.md-heading {
  color: var(--syntax-keyword);
  font-weight: bold;
}

/* Rosa */
.md-quote {
  color: var(--syntax-comment);
  font-style: italic;
  border-left: 3px solid var(--vscode-border);
  padding-left: 10px;
  margin-left: 2px;
}

/* Cinza com borda lateral */
.md-hr {
  color: var(--vscode-text-muted);
  letter-spacing: 2px;
  font-weight: bold;
}

.md-link {
  color: var(--syntax-property);
  text-decoration: none;
  transition: color 0.2s;
}

/* Ciano */
.md-link:hover {
  text-decoration: underline;
  color: var(--theme-accent);
}

.md-url {
  color: var(--vscode-text-muted);
}

.md-bold {
  color: var(--syntax-var);
  font-weight: bold;
}

.md-italic {
  color: var(--syntax-string);
  font-style: italic;
}

/* Amarelo/Laranja */
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