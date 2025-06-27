# Etapa 1: Backend Laravel con PHP-FPM
FROM php:8.2-fpm as backend

# Dependencias necesarias
RUN apt-get update && apt-get install -y \
    unzip curl libzip-dev libpng-dev libonig-dev zip git \
    && docker-php-ext-install pdo pdo_mysql zip

# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copia código fuente
WORKDIR /var/www/html
COPY . .

# Instala dependencias Laravel
RUN composer install --no-dev --optimize-autoloader

# Da permisos a Laravel
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage


# Etapa 2: Caddy + PHP
FROM caddy:2-builder AS builder

# Etapa final: Contenedor de aplicación con Caddy y PHP-FPM
FROM caddy:2

COPY --from=backend /var/www/html /var/www/html
COPY Caddyfile /etc/caddy/Caddyfile

# Caddy servirá los archivos y redirigirá peticiones PHP a php-fpm
