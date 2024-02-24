<template>
  <div>
    <h2 class="header">
      <img src="../assets/images/memo_3d.png">
      {{ $t("blog.title") }}
    </h2>

    <a
      href="#"
      class="blog-post-link"
    >
    </a>
  </div>
</template>

<style scoped>
img {
  height: 1.6rem;
}

.blog-post b {
  color: var(--color-text-secondary);
}

.blog-post {
  margin-top: 1rem;
  padding-bottom: 0.5rem;
}

.blog-post-link {
  display: block;
  margin-bottom: 2rem;
  transition: all 0.3s;
}

.blog-post-link div b {
  transition: all 0.3s;
}

.blog-post-link:hover div b {
  color: var(--color-text-primary);
}
</style>
