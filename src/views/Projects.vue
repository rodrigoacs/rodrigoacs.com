<template>
  <div class="vscode-code-block">
    <p><span class="comment">/**</span></p>
    <p><span class="comment"> * Catálogo de projetos pessoais e em desenvolvimento.</span></p>
    <p><span class="comment"> */</span></p>

    <p>
      <span class="keyword">import</span> <span class="text">{</span> <span class="type">Project</span> <span
        class="text"
      >}</span> <span class="keyword">from</span> <span class="string">'@/types/portfolio'</span><span
        class="text">;</span>
    </p>
    <br />

    <p>
      <span class="keyword">export const</span> <span class="var">recentProjects</span><span class="text">: </span><span
        class="type"
      >Project</span><span class="text">[] = [</span>
    </p>

    <div class="indent">
      <p><span class="text">{</span></p>
      <div class="indent">
        <p>
          <span class="property">name</span><span class="text">: </span><span class="string">'Flint'</span><span
            class="text"
          >,</span>
        </p>
        <p>
          <span class="property">description</span><span class="text">: </span><span class="string">'Command-line tool
            (CLI) para conversão de arquivos.'</span><span class="text">,</span>
        </p>
        <p>
          <span class="property">stack</span><span class="text">: [</span><span class="string">'Node.js'</span><span
            class="text"
          >, </span><span class="string">'CLI'</span><span class="text">],</span>
        </p>
        <p>
          <span class="property">status</span><span class="text">: </span><span class="string">'Em
            desenvolvimento'</span>
        </p>
      </div>
      <p><span class="text">},</span></p>
    </div>

    <div class="indent">
      <p><span class="text">{</span></p>
      <div class="indent">
        <p>
          <span class="property">name</span><span class="text">: </span><span class="string">'restoque'</span><span
            class="text"
          >,</span>
        </p>
        <p>
          <span class="property">description</span><span class="text">: </span><span class="string">'Sistema com
            comunicação em tempo real via WebSockets.'</span><span class="text">,</span>
        </p>
        <p>
          <span class="property">stack</span><span class="text">: [</span><span class="string">'Node.js'</span><span
            class="text"
          >, </span><span class="string">'WebSockets'</span><span class="text">],</span>
        </p>
        <p>
          <span class="property">status</span><span class="text">: </span><span class="string">'Concluído'</span>
        </p>
      </div>
      <p><span class="text">},</span></p>
    </div>

    <div class="indent">
      <p><span class="text">{</span></p>
      <div class="indent">
        <p>
          <span class="property">name</span><span class="text">: </span><span class="string">'MTG Collection
            Tracker'</span><span class="text">,</span>
        </p>
        <p>
          <span class="property">description</span><span class="text">: </span><span class="string">'Web app para
            gerenciar coleção de Magic: The Gathering, incluindo a coleção de The Lord of the Rings e integração com
            Google Sheets.'</span><span class="text">,</span>
        </p>
        <p>
          <span class="property">stack</span><span class="text">: [</span><span class="string">'JavaScript'</span><span
            class="text"
          >, </span><span class="string">'Google Sheets API'</span><span class="text">],</span>
        </p>
        <p>
          <span class="property">status</span><span class="text">: </span><span class="string">'Ativo'</span>
        </p>
      </div>
      <p><span class="text">},</span></p>
    </div>

    <div class="indent">
      <p><span class="text">{</span></p>
      <div class="indent">
        <p>
          <span class="property">name</span><span class="text">: </span><span class="string">'Personal Finance
            App'</span><span class="text">,</span>
        </p>
        <p>
          <span class="property">description</span><span class="text">: </span><span class="string">'Aplicação web para
            controle financeiro pessoal.'</span><span class="text">,</span>
        </p>
        <p>
          <span class="property">stack</span><span class="text">: [</span><span class="string">'Node.js'</span><span
            class="text"
          >, </span><span class="string">'Vue.js'</span><span class="text">],</span>
        </p>
        <p>
          <span class="property">status</span><span class="text">: </span><span class="string">'Em
            desenvolvimento'</span>
        </p>
      </div>
      <p><span class="text">}</span></p>
    </div>

    <p><span class="text">];</span><span class="cursor"></span></p>
  </div>
</template>

<style scoped>
.vscode-code-block {
  font-size: 14px;
}

p {
  margin-bottom: 0;
  white-space: pre-wrap;
}

.indent {
  margin-left: 2rem;
}

/* Destaque de Sintaxe - Monokai */
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