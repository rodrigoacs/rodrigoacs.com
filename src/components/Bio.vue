<template>
  <div>
    <h2 class="header">
      <img src="../assets/images/brain_3d.png">
      {{ $t("bio.hello") }}
    </h2>

    <p>
      {{ $t("bio.p1") }}
    </p>

    <p>
      {{ $t("bio.p2") }}
    </p>

    <p>
      {{ $t("bio.p3") }}
    </p>
  </div>
</template>

<style scoped>
img {
  height: 1.6rem;
}

h2 {
  margin-bottom: 0.8rem;
}

p {
  margin-bottom: 0.8rem;
}
</style>
