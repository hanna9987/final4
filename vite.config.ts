import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: true, // 외부 접속 허용
    port: 5173,
    allowedHosts: [
      'localhost',
      '.ngrok.io',
      '.ngrok-free.app',
      'c6d5-175-214-183-100.ngrok-free.app'
    ]
  }
}) 