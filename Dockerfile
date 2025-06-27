# Imagen base con PHP-FPM
FROM php:8.2-fpm

# Imagen base con PHP-FPM
FROM php:8.2-fpm

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    unzip curl libzip-dev libpng-dev libonig-dev zip git gnupg2 lsb-release apt-transport-https ca-certificates \
    && docker-php-ext-install pdo pdo_mysql zip

# Instalar Caddy (versión estable compatible)
RUN curl -fsSL https://apt.fury.io/caddy/gpg.key | gpg --dearmor -o /usr/share/keyrings/caddy-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/caddy-archive-keyring.gpg] https://apt.fury.io/caddy/ /" \
    | tee /etc/apt/sources.list.d/caddy-fury.list \
    && apt-get update && apt-get install -y caddy

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copiar el proyecto
WORKDIR /var/www/html
COPY . .

# Instalar dependencias de Laravel
RUN composer install --no-dev --optimize-autoloader \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage

# Expone el puerto 80 (usado por Caddy)
EXPOSE 80

# Comando de inicio para Caddy
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
