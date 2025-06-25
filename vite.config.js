import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  plugins: [
    laravel({
      input: [
        'resources/css/app.css',
        'resources/js/app.js',
      ],
      refresh: true,
      buildDirectory: 'build', // Carpeta dentro de public donde se colocan assets
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
    },
  },
  base: '/', // URL base para assets; cámbialo si usas CDN o dominio distinto
});
