import { ref} from "vue";
import { fetchHello } from "@/api";

export function useHello() {
  const message = ref("");
  const loading = ref(false);

  async function load() {
    loading.value = true;
    try {
      const data = await fetchHello();
      message.value = data.message ?? "";
    } finally {
      loading.value = false;
    }
  }

  return { message, loading, load };
}