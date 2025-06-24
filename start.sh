#!/bin/sh

echo "▶️ Iniciando aplicación Laravel..."

MAX_TRIES=30
TRIES=0

# Espera a que la base de datos esté disponible (máximo 30 intentos)
until nc -z "$DB_HOST" "$DB_PORT"; do
  if [ "$TRIES" -ge "$MAX_TRIES" ]; then
    echo "❌ Error: No se pudo conectar a la base de datos en $DB_HOST:$DB_PORT"
    exit 1
  fi

  echo "⏳ Esperando a la base de datos... (intento $((TRIES + 1)))"
  TRIES=$((TRIES + 1))
  sleep 2
done

echo "✅ Base de datos disponible. Ejecutando migraciones..."

# Migraciones forzadas
php artisan migrate --force

echo "🧠 Cacheando configuración..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "🚀 Iniciando PHP-FPM..."
exec php-fpm
