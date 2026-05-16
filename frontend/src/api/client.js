import axios from "axios";

export const apiClient = axios.create({
  baseURL: "",
  headers: { Accept: "application/json" },
  withCredentials: true, // Allows the browser to attach cookies to requests
  timeout: 5000,
});