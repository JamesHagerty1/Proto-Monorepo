<script setup>
  import { onMounted } from "vue";
  import { useHello } from "@/composables/use-hello";

  const { message, loading, load } = useHello();

  onMounted(() => {
    load();
  });
</script>

<template>
  <main>
    <p v-if="loading">Loading…</p>
    <p v-else>{{ message }}</p>
  </main>
</template>