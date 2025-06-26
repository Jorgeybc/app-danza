#!/bin/sh

echo "Iniciando Laravel + Caddy..."

php-fpm &

# Esperar a que php-fpm levante
sleep 3

php artisan migrate --force
php artisan config:cache
php artisan route:cache
php artisan view:cache

exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
