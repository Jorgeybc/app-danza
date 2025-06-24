#!/bin/sh

# Esperar a que la base de datos esté lista
until nc -z $DB_HOST $DB_PORT; do
  echo "Esperando a la base de datos..."
  sleep 2
done

# Migraciones automáticas
php artisan migrate --force

# Opcional: cachear config, rutas y vistas
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Iniciar PHP-FPM
php-fpm
