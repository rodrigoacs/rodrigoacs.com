<template>
  <div class="vscode-code-block">
    <div class="code-line"><span class="comment">// {{ t('settings.comment') }}</span></div>
    <div class="code-line"><span class="text">{</span></div>

    <div class="code-line pl-1">
      <span class="property">"{{ t('settings.fontSize') }}"</span><span class="text">: </span>
      <input
        type="number"
        v-model="globalSettings['editor.fontSize']"
        class="json-input num"
        min="10"
        max="24"
      />
      <span class="text">,</span>
    </div>

    <div class="code-line pl-1">
      <span class="property">"{{ t('settings.theme') }}"</span><span class="text">: </span><span class="string">"</span>
      <select
        v-model="globalSettings['workbench.colorTheme']"
        class="json-select"
      >
        <option value="Monokai Spectrum">Monokai Spectrum</option>
        <option value="Dracula">Dracula</option>
      </select>
      <span class="string">"</span>
    </div>

    <div class="code-line"><span class="text">}</span><span class="cursor"></span></div>
  </div>
</template>

<script setup>
import { useSettings } from '@/composables/useSettings'
import { useI18n } from 'vue-i18n' // <-- IMPORTAÇÃO DO TRADUTOR

const { globalSettings } = useSettings()
const { t } = useI18n() // <-- EXTRAÇÃO DO TRADUTOR
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
  line-height: 1.6;
}

.code-line:hover {
  background-color: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.json-input,
.json-select {
  background: transparent;
  border: 1px dashed transparent;
  color: var(--syntax-string);
  font-family: inherit;
  font-size: inherit;
  outline: none;
  cursor: pointer;
  transition: border 0.2s;
  appearance: none;
  -webkit-appearance: none;
}

.json-input.num {
  color: var(--syntax-var);
  width: 40px;
  text-align: center;
}

.json-input:hover,
.json-select:hover {
  border-bottom: 1px dashed var(--theme-accent);
}

.json-input:focus,
.json-select:focus {
  border-bottom: 1px solid var(--theme-accent);
}

.json-select option {
  background-color: var(--vscode-bg);
  color: var(--vscode-text);
}

.comment {
  color: var(--syntax-comment);
}

.property {
  color: var(--syntax-func);
}

.string {
  color: var(--syntax-string);
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