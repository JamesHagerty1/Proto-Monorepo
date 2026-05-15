import { apiClient } from "@/api/client";

export async function getHello() {
  const { data } = await apiClient.get("/api/v1/hello");
  return data;
}