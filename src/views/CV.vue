<template>
  <div class="vscode-code-block">
    <div class="code-line"><span class="text">{</span></div>

    <div class="code-line pl-1">
      <span class="property">"filename"</span><span class="text">: </span><span class="string">"{{ t('cv.filename')
      }}"</span><span class="text">,</span>
    </div>

    <div class="code-line pl-1">
      <span class="property">"contact"</span><span class="text">: {</span>
    </div>
    <div class="code-line pl-2"><span class="property">"email"</span><span class="text">: </span><span
        class="string">"{{ t('cv.email') }}"</span><span class="text">,</span></div>
    <div class="code-line pl-2"><span class="property">"github"</span><span class="text">: </span><span
        class="string">"{{ t('cv.github') }}"</span><span class="text">,</span></div>
    <div class="code-line pl-2"><span class="property">"linkedin"</span><span class="text">: </span><span
        class="string">"{{ t('cv.linkedin') }}"</span><span class="text">,</span></div>
    <div class="code-line pl-2"><span class="property">"website"</span><span class="text">: </span><span
        class="string">"{{ t('cv.website') }}"</span></div>
    <div class="code-line pl-1"><span class="text">},</span></div>

    <div class="code-line pl-1">
      <span class="property">"summary"</span><span class="text">: </span><span class="string">"{{ t('cv.summary')
      }}"</span><span class="text">,</span>
    </div>

    <div class="code-line pl-1">
      <span class="property">"experience"</span><span class="text">: [</span>
    </div>

    <template
      v-for="(exp, index) in tm('cv.experiences')"
      :key="'exp-'+index"
    >
      <div class="code-line pl-2"><span class="text">{</span></div>
      <div class="code-line pl-3"><span class="property">"company"</span><span class="text">: </span><span
          class="string"
        >"{{ exp.company }}"</span><span class="text">,</span></div>
      <div class="code-line pl-3"><span class="property">"role"</span><span class="text">: </span><span
          class="string">"{{ exp.role }}"</span><span class="text">,</span></div>
      <div class="code-line pl-3"><span class="property">"period"</span><span class="text">: </span><span
          class="string">"{{ exp.period }}"</span><span class="text">,</span></div>
      <div class="code-line pl-3"><span class="property">"description"</span><span class="text">: </span><span
          class="string"
        >"{{ exp.description }}"</span></div>
      <div class="code-line pl-2"><span class="text">}{{ index <
        tm('cv.experiences').length
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
      <span class="property">"education"</span><span class="text">: [</span>
    </div>

    <template
      v-for="(edu, index) in tm('cv.educations')"
      :key="'edu-'+index"
    >
      <div class="code-line pl-2"><span class="text">{</span></div>
      <div class="code-line pl-3"><span class="property">"institution"</span><span class="text">: </span><span
          class="string"
        >"{{ edu.local }}"</span><span class="text">,</span></div>
      <div class="code-line pl-3"><span class="property">"course"</span><span class="text">: </span><span
          class="string">"{{ edu.course }}"</span><span class="text">,</span></div>
      <div class="code-line pl-3"><span class="property">"period"</span><span class="text">: </span><span
          class="string">"{{ edu.time }}"</span></div>
      <div class="code-line pl-2"><span class="text">}{{ index <
        tm('cv.educations').length
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
      <span class="property">"skills"</span><span class="text">: {</span>
    </div>
    <div class="code-line pl-2"><span class="property">"languages"</span><span class="text">: </span><span
        class="string"
      >"{{ t('cv.skills.lang') }}"</span><span class="text">,</span></div>
    <div class="code-line pl-2"><span class="property">"frameworks_and_architecture"</span><span class="text">:
      </span><span class="string">"{{ t('cv.skills.arch') }}"</span><span class="text">,</span></div>
    <div class="code-line pl-2"><span class="property">"databases"</span><span class="text">: </span><span
        class="string"
      >"{{ t('cv.skills.db') }}"</span><span class="text">,</span></div>
    <div class="code-line pl-2"><span class="property">"cloud_and_devops"</span><span class="text">: </span><span
        class="string"
      >"{{ t('cv.skills.devops') }}"</span><span class="text">,</span></div>
    <div class="code-line pl-2"><span class="property">"methodologies"</span><span class="text">: </span><span
        class="string"
      >"{{ t('cv.skills.method') }}"</span></div>
    <div class="code-line pl-1"><span class="text">},</span></div>

    <div class="code-line pl-1">
      <span class="property">"actions"</span><span class="text">: {</span>
    </div>
    <div class="code-line pl-2"><span class="property">"download_pdf"</span><span class="text">: </span><span
        class="keyword"
      >function</span><span class="text">() {</span></div>
    <div class="code-line pl-3"><span class="comment">// {{ t('cv.download_comment') }}</span></div>
    <div class="code-line pl-3"><span class="text">window.open(</span><a
        href="soon"
        target="_blank"
        download
        class="string download-link"
      >"soon"</a><span class="text">);</span>
    </div>
    <div class="code-line pl-2"><span class="text">}</span></div>
    <div class="code-line pl-1"><span class="text">}</span></div>

    <div class="code-line"><span class="text">}</span><span class="cursor"></span></div>
  </div>
</template>

<script setup>
import { useI18n } from 'vue-i18n'
const { t, tm } = useI18n()
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

.pl-3 {
  padding-left: 5rem !important;
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

.property {
  color: var(--syntax-func);
}

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