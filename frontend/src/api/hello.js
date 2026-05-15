import { apiClient } from "@/api/client";

export async function fetchHello() {
  const { data } = await apiClient.get("/api/v1/hello");
  return data;
}