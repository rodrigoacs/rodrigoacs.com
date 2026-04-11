<template>
  <div class="vscode-code-block">
    <div class="code-line"><span class="text">{</span></div>

    <div class="code-line pl-1">
      <span class="property">"filename"</span><span class="text">: </span><span
        class="string">"cv_rodrigosoares.pdf"</span><span class="text">,</span>
    </div>

    <div class="code-line pl-1">
      <span class="property">"contact"</span><span class="text">: {</span>
    </div>
    <div class="code-line pl-2"><span class="property">"email"</span><span class="text">: </span><span
        class="string">"rodrigohths@gmail.com"</span><span class="text">,</span></div>
    <div class="code-line pl-2"><span class="property">"github"</span><span class="text">: </span><span
        class="string">"https://github.com/rodrigoacs"</span><span class="text">,</span></div>
    <div class="code-line pl-2"><span class="property">"linkedin"</span><span class="text">: </span><span
        class="string">"https://www.linkedin.com/in/rodrigoacsoares/"</span></div>
    <div class="code-line pl-1"><span class="text">},</span></div>

    <div class="code-line pl-1">
      <span class="property">"education"</span><span class="text">: [</span>
    </div>

    <template
      v-for='(edu, index) in $tm("cv.educations")'
      :key='index'
    >
      <div class="code-line pl-2"><span class="text">{</span></div>
      <div class="code-line pl-3"><span class="property">"time"</span><span class="text">: </span><span
          class="string">"{{ edu.time }}"</span><span class="text">,</span></div>
      <div class="code-line pl-3"><span class="property">"local"</span><span class="text">: </span><span
          class="string">"{{ edu.local }}"</span><span class="text">,</span></div>
      <div class="code-line pl-3"><span class="property">"course"</span><span class="text">: </span><span
          class="string">"{{ edu.course }}"</span></div>
      <div class="code-line pl-2"><span class="text">}{{ index <
        $tm("cv.educations").length
            -
            1
            ? ','
            : ''
            }}</span
          >
      </div>
    </template>

    <div class="code-line pl-1"><span class="text">],</span></div>

    <div class="code-line pl-1">
      <span class="property">"skills"</span><span class="text">: [</span>
    </div>
    <div class="code-line pl-2"><span class="string">"{{ $t("cv.skills1") }}"</span><span class="text">,</span></div>
    <div class="code-line pl-2"><span class="string">"{{ $t("cv.skills2") }}"</span><span class="text">,</span></div>
    <div class="code-line pl-2"><span class="string">"{{ $t("cv.skills3") }}"</span></div>
    <div class="code-line pl-1"><span class="text">],</span></div>

    <div class="code-line pl-1">
      <span class="property">"actions"</span><span class="text">: {</span>
    </div>
    <div class="code-line pl-2"><span class="property">"download_pdf"</span><span class="text">: </span><span
        class="keyword"
      >function</span><span class="text">() {</span></div>
    <div class="code-line pl-3"><span class="comment">// Clique no link abaixo para baixar o arquivo</span></div>
    <div class="code-line pl-3"><span class="text">window.open(</span><a
        href="https://librishelf.com/download/cv_RodrigoSoares.pdf"
        target="_blank"
        download
        class="string download-link"
      >"https://librishelf.com/download/cv_RodrigoSoares.pdf"</a><span class="text">);</span>
    </div>
    <div class="code-line pl-2"><span class="text">}</span></div>
    <div class="code-line pl-1"><span class="text">}</span></div>

    <div class="code-line"><span class="text">}</span><span class="cursor"></span></div>
  </div>
</template>

<style scoped>
.vscode-code-block {
  font-size: 14px;
}

/* Identação via Padding (JSON precisa de um nível a mais - pl-3) */
.pl-1 {
  padding-left: 2rem !important;
}

.pl-2 {
  padding-left: 3.5rem !important;
}

.pl-3 {
  padding-left: 5rem !important;
}

/* Destaque da Linha Ativa */
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

/* Destaque de Sintaxe - Monokai JSON */
.property {
  color: var(--syntax-func);
}

/* Verde para chaves JSON */
.string {
  color: var(--syntax-string);
}

.text {
  color: var(--vscode-text);
}

.keyword {
  color: var(--syntax-keyword);
  font-style: italic;
}

.comment {
  color: var(--syntax-comment);
}

.download-link {
  text-decoration: underline;
  cursor: pointer;
  transition: opacity 0.2s;
}

.download-link:hover {
  opacity: 0.8;
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