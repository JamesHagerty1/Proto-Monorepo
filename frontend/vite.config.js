import { fileURLToPath, URL } from "node:url";

import { defineConfig } from "vite";  
import vue from "@vitejs/plugin-vue";
import vueDevTools from "vite-plugin-vue-devtools";

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    vueDevTools(),
  ],
  resolve: {
    alias: {
      "@": fileURLToPath(new URL("./src", import.meta.url))
    },
  },
  // Tells Vite's dev server that any path starting with "/api" should be sent
  // to the local backend server, and makes the requests to backend server look
  // like direct client to API requests, by making the `Host` header that of
  // the API instead of the Vite dev server.
  server: {
    proxy: {
      "/api": {
        target: "http://127.0.0.1:3000",
        changeOrigin: true,
      },
    },
  },
});
