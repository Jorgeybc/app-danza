FROM caddy:2 AS caddy

FROM node:18 AS node

FROM php:8.2-fpm

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y \
    unzip curl libzip-dev zip git npm \
    && docker-php-ext-install pdo pdo_mysql zip

# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copia Caddy desde la imagen oficial
COPY --from=caddy /usr/bin/caddy /usr/bin/caddy

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Copia todo el proyecto
COPY . .

# Instala dependencias
RUN composer install --no-dev --optimize-autoloader
RUN npm install && npm run build

# Permisos necesarios
RUN chmod -R 775 storage bootstrap/cache

# Copia el Caddyfile
COPY Caddyfile /etc/caddy/Caddyfile

# Expone el puerto 80
EXPOSE 80

# Comando de inicio
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
