# Etapa 1: PHP-FPM + Composer
FROM php:8.2-fpm as php

RUN apt-get update && apt-get install -y \
    unzip curl libzip-dev libpng-dev libonig-dev zip git \
    && docker-php-ext-install pdo pdo_mysql zip

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
COPY . .

RUN composer install --no-dev --optimize-autoloader \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage

# Etapa 2: Caddy (servidor)
FROM caddy:2

# Copiar Caddyfile
COPY Caddyfile /etc/caddy/Caddyfile

# Copiar el código del proyecto Laravel
COPY --from=php /var/www/html /var/www/html

# Caddy sirve en :80 por defecto
