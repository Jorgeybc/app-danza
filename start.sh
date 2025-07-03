#!/bin/bash

# Limpiar cachés (si existían)
php artisan config:clear
php artisan route:clear
php artisan view:clear

# Generar clave si no existe
if [ -z "$APP_KEY" ]; then
  echo "APP_KEY not found in environment. Exiting..."
  exit 1
fi

# Cachear configuración
php artisan config:cache

# Migraciones forzadas
php artisan migrate --force

# Iniciar supervisord (Caddy + PHP-FPM)
exec /usr/bin/supervisord -c /etc/supervisord.conf
