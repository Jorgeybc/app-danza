#!/bin/sh

echo "▶️ Iniciando aplicación Laravel..."

# Esperar a que la base de datos esté disponible
until nc -z "$DB_HOST" "$DB_PORT"; do
  echo "⏳ Esperando a la base de datos..."
  sleep 2
done

echo "✅ Base de datos disponible. Ejecutando migraciones..."
php artisan migrate --force

echo "🧠 Cacheando configuración..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "🚀 Iniciando servicios..."

# Ejecutar php-fpm en segundo plano
php-fpm &

# Esperar un par de segundos para evitar que Caddy falle si PHP no está listo
sleep 2

# Iniciar Caddy como proceso principal
exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
