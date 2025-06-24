#!/bin/sh

# Esperar a que la base de datos esté lista
until nc -z $DB_HOST $DB_PORT; do
  echo "Esperando a la base de datos..."
  sleep 2
done

# Ejecutar migraciones
php artisan migrate --force

# Cachear configuración, rutas y vistas (opcional pero recomendado en producción)
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Iniciar PHP-FPM
php-fpm
