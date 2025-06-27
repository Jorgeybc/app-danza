#!/bin/sh

# Generar APP_KEY si no existe
if [ ! -f ".env" ]; then
  cp .env.example .env
fi

php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan key:generate --force

# Iniciar servidor Laravel
php artisan serve --host=0.0.0.0 --port=8000
