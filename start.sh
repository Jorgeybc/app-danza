#!/bin/sh

echo "▶️ Iniciando aplicación Laravel..."

# Esperar a la base de datos
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

echo "▶️ Iniciando supervisord..."
exec supervisord -c /etc/supervisord.conf
