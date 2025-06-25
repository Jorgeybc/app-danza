import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  cacheDir: 'node_modules/.vite',  // mueve caché afuera de public/build/.vite
  plugins: [
    laravel({
      input: [
        'resources/css/app.css',
        'resources/js/app.js',
      ],
      refresh: true,
    }),
    tailwindcss(),
  ],
  build: {
    manifest: true,
    outDir: 'public/build',
    rollupOptions: {
      input: [
        'resources/css/app.css',
        'resources/js/app.js',
      ],
      output: {
        dir: 'public/build',
      },
    },
  },
  base: '/',
});
