<template>
  <div class="wrapper">
    <div class="content-wrapper">
      <Navigation />

      <RouterView v-slot="{ Component }">
        <Transition
          name="fade"
          mode="out-in"
        >
          <component :is="Component" />
        </Transition>
      </RouterView>

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
  display: flex;
  flex-direction: column;
  position: relative;
  min-height: 100vh;
}

.content-wrapper {
  padding: 20px;
  flex-grow: 1;
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>