import { createApp } from "vue";
import { createPinia } from "pinia";

import App from "./App.vue";
import router from "./router";

import "./assets/main.css";

import PrimeVue from "primevue/config";
import { AppPreset } from "./theme";

const app = createApp(App);

app.use(PrimeVue, {
  theme: {
    preset: AppPreset,
    options: {
      darkModeSelector: false,
    }
  },
});

app.use(createPinia());

app.use(router);

app.mount("#app");
