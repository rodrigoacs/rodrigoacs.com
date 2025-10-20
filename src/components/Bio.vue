<template>
  <section class="bio-hero">

    <div class="bio-image mobile">
      <img
        src="../assets/images/brain_3d.webp"
        alt="Ilustração de um cérebro"
      >
    </div>

    <div class="bio-text">
      <h1>{{ $t("bio.hello") }}</h1>
      <p class="subtitle">{{ $t("bio.subtitle") }}</p>
      <p class="subtitle-2">{{ $t("bio.subtitle_line2") }}</p>

      <div class="bio-links">
        <a
          href="https://github.com/rodrigoacs"
          target="_blank"
          rel="noopener noreferrer"
        >
          <img
            src="../assets/images/icons8-github-logo-1500.webp"
            class="icon"
          >
          {{ $t("bio.links.github") }}
        </a>
        <a
          href="https://www.linkedin.com/in/rodrigoacsoares/"
          target="_blank"
          rel="noopener noreferrer"
        >
          <img
            src="../assets/images/icons8-linkedin-94.webp"
            class="icon"
          >
          {{ $t("bio.links.linkedin") }}
        </a>
        <a href="mailto:contato@rodrigoacs.com">
          <img
            src="../assets/images/icons8-gmail-logo-94.webp"
            class="icon"
          >
          {{ $t("bio.links.email") }}
        </a>
      </div>
    </div>

    <div class="bio-image desktop">
      <img
        src="../assets/images/brain_3d.webp"
        alt="Ilustração de um cérebro"
      >
    </div>
  </section>

  <section class="bio-details">
    <p>{{ $t("bio.p1") }}</p>
    <p>{{ $t("bio.p2") }}</p>
    <p>{{ $t("bio.p3") }}</p>
  </section>
</template>

<script setup>
</script>

<style scoped>
.bio-hero {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  margin-top: 2rem;
  padding-block: 2rem;
  border-bottom: 1px solid var(--color-hover);
}

.bio-image {
  margin-bottom: 1.5rem;
}

.bio-image img {
  width: 120px;
  height: 120px;
  object-fit: contain;
  filter: drop-shadow(0 4px 10px rgba(0, 0, 0, 0.1));
}

.bio-image.desktop {
  display: none;
}

.bio-text {
  width: 100%;
}

h1 {
  font-size: 2.5rem;
  font-weight: 700;
  color: var(--color-text-primary);
  margin-bottom: 0.5rem;
  line-height: 1.2;
}

.subtitle {
  font-size: 1.125rem;
  font-weight: 500;
  color: var(--color-text-highlight);
  margin-bottom: 0.25rem;
}

.subtitle-2 {
  font-size: 1rem;
  color: var(--color-text-secondary);
  margin-bottom: 1.5rem;
}

.bio-links {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 1.5rem;
}

.bio-links a {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: var(--color-text-secondary);
  font-weight: 500;
  text-decoration: none;
  transition: color 0.2s ease;
}

.bio-links a:hover {
  color: var(--color-text-primary);
}

.bio-links .icon {
  width: 20px;
  height: 20px;
}

.bio-details {
  border-bottom: 1px solid var(--color-hover);
  padding-block: 2rem;
}

.bio-details p {
  margin-bottom: 0.8rem;
  font-size: 1rem;
  line-height: 1.7;
}

@media screen and (min-width: 768px) {
  .bio-hero {
    flex-direction: row;
    text-align: left;
    gap: 2rem;
    margin-top: 4rem;
  }

  .bio-image.mobile {
    display: none;
  }

  .bio-image.desktop {
    display: block;
    order: 2;
    flex-basis: 200px;
    flex-shrink: 0;
  }

  .bio-image.desktop img {
    width: 200px;
    height: 200px;
  }

  .bio-text {
    order: 1;
  }

  h1 {
    font-size: 3.5rem;
  }

  .subtitle {
    font-size: 1.25rem;
  }

  .bio-links {
    justify-content: flex-start;
  }
}
</style>