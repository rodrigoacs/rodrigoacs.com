<template>
  <div class="vscode-code-block">
    <div class="code-line"><span class="comment">/**</span></div>
    <div class="code-line"><span class="comment"> * {{ $t("bio.hello") }}</span></div>
    <div class="code-line"><span class="comment"> */</span></div>

    <div class="code-line">
      <span class="keyword">const</span> <span class="var">developerProfile</span><span class="text">: </span><span
        class="type"
      >Developer</span> <span class="keyword">=</span> <span class="text">{</span>
    </div>

    <div class="code-line pl-1">
      <span class="property">name</span><span class="text">: </span><span class="string">'Rodrigo Augusto Correa
        Soares'</span><span class="text">,</span>
    </div>
    <div class="code-line pl-1">
      <span class="property">role</span><span class="text">: </span>
      <span class="string tooltip-trigger">'Fullstack Developer'</span><span class="text">,</span>
    </div>
    <div class="code-line pl-1">
      <span class="property">location</span><span class="text">: </span><span class="string">'Minas Gerais,
        Brasil'</span><span class="text">,</span>
    </div>
    <div class="code-line pl-1">
      <span class="property">bio</span><span class="text">: </span><span class="string">`{{ $t("bio.p1") }}</span>
    </div>
    <div class="code-line pl-2">
      <span class="string">{{ $t("bio.p2") }}</span>
    </div>
    <div class="code-line pl-2">
      <span class="string">{{ $t("bio.p3") }}`</span><span class="text">,</span>
    </div>
    <div class="code-line pl-1">
      <span class="property">hobbies</span><span class="text">: [</span><span class="string">'Magic: The
        Gathering'</span><span class="text">, </span><span class="string">'3D Printing'</span><span
        class="text">]</span>
    </div>

    <div class="code-line"><span class="text">};</span></div>
    <br />
    <div class="code-line"><span class="keyword">export default</span> <span class="var">developerProfile</span><span
        class="text"
      >;</span><span class="cursor"></span></div>
  </div>
</template>

<style scoped>
.vscode-code-block {
  font-size: 14px;
}

.pl-1 {
  padding-left: 2rem !important;
}

.pl-2 {
  padding-left: 3rem !important;
}

/* Destaque da Linha Ativa com o padding embutido */
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

/* IntelliSense Tooltip */
.tooltip-trigger {
  text-decoration: underline dashed var(--vscode-text-muted);
  cursor: help;
  position: relative;
}

.tooltip-trigger:hover::after {
  content: 'type DeveloperRole = "Frontend" | "Backend" | "Fullstack"';
  position: absolute;
  bottom: 100%;
  left: 0;
  margin-bottom: 5px;
  background-color: var(--vscode-sidebar-bg);
  border: 1px solid var(--vscode-border);
  padding: 4px 8px;
  border-radius: 4px;
  color: var(--vscode-text);
  font-family: 'Consolas', monospace;
  font-size: 12px;
  white-space: nowrap;
  z-index: 100;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
  pointer-events: none;
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