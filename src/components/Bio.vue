<template>
  <div class="vscode-code-block">
    <p><span class="comment">/**</span></p>
    <p><span class="comment"> * {{ $t("bio.hello") }}</span></p>
    <p><span class="comment"> */</span></p>

    <p>
      <span class="keyword">const</span> <span class="var">developerProfile</span><span class="text">: </span><span
        class="type"
      >Developer</span> <span class="keyword">=</span> <span class="text">{</span>
    </p>

    <div class="indent">
      <p>
        <span class="property">name</span><span class="text">: </span><span class="string">'Rodrigo Augusto Correa
          Soares'</span><span class="text">,</span>
      </p>
      <p>
        <span class="property">role</span><span class="text">: </span><span class="string">'Fullstack
          Developer'</span><span class="text">,</span>
      </p>
      <p>
        <span class="property">location</span><span class="text">: </span><span class="string">'Minas Gerais,
          Brasil'</span><span class="text">,</span>
      </p>
      <p>
        <span class="property">bio</span><span class="text">: </span><span class="string">`{{ $t("bio.p1") }}</span>
      </p>
      <p class="indent-more">
        <span class="string">{{ $t("bio.p2") }}</span>
      </p>
      <p class="indent-more">
        <span class="string">{{ $t("bio.p3") }}`</span><span class="text">,</span>
      </p>
      <p>
        <span class="property">hobbies</span><span class="text">: [</span><span class="string">'Magic: The
          Gathering'</span><span class="text">, </span><span class="string">'3D Printing'</span><span
          class="text">]</span>
      </p>
    </div>

    <p><span class="text">};</span></p>
    <br />
    <p><span class="keyword">export default</span> <span class="var">developerProfile</span><span
        class="text">;</span><span class="cursor"></span></p>
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

.indent-more {
  margin-left: 1rem;
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