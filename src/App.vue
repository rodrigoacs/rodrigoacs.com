<template>
  <div class="wrapper">
    <div class="content-wrapper">
      <Navigation />

      <RouterView />
    </div>

    <FooterVue class="footer" />
  </div>
</template>

<script setup>
import Navigation from '@/components/Navigation.vue'
import FooterVue from '@/components/Footer.vue'
</script>

<style scoped>
.wrapper {
  position: relative;
  min-height: 100vh;
}

.content-wrapper {
  padding: 20px;
  padding-bottom: 60px;
}

.footer {
  position: absolute;
  bottom: 0;
  width: 100%;
}
</style>
kdjasiodj