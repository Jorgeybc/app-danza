import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import { resolve } from 'path';
import fs from 'fs';

export default defineConfig({
  plugins: [
    laravel({
      input: [
        'resources/css/app.css',
        'resources/js/app.js',
      ],
      refresh: true,
    }),
    {
      name: 'fix-laravel-manifest',
      closeBundle() {
        const originalPath = 'public/build/.vite/manifest.json';
        const newPath = 'public/build/manifest.json';
        if (fs.existsSync(originalPath)) {
          fs.copyFileSync(originalPath, newPath);
          console.log('✅ Manifest movido a public/build/manifest.json');
        } else {
          console.warn('⚠️ No se encontró el manifest original');
        }
      },
    },
  ],
  build: {
    outDir: 'public/build',
    emptyOutDir: true,
    manifest: true,
    rollupOptions: {
      input: {
        app: resolve('resources/js/app.js'),
      },
      output: {
        entryFileNames: 'assets/[name]-[hash].js',
        chunkFileNames: 'assets/[name]-[hash].js',
        assetFileNames: 'assets/[name]-[hash][extname]',
      },
    },
  },
});
