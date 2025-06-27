# Base: PHP con extensiones necesarias
FROM php:8.2-fpm

# Instala dependencias necesarias y Caddy
RUN apt-get update && apt-get install -y \
    unzip curl libzip-dev libpng-dev libonig-dev zip git gnupg2 ca-certificates debian-keyring debian-archive-keyring \
    && docker-php-ext-install pdo pdo_mysql zip \
    && curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy.gpg \
    && curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list \
    && apt-get update && apt-get install -y caddy

# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copia proyecto Laravel
WORKDIR /var/www/html
COPY . .

# Permisos
RUN composer install --no-dev --optimize-autoloader \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage

# Expone puerto 80 para Render
EXPOSE 80

# Usa Caddy como comando principal
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
