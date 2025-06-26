# Etapa 1: Build de Vite
FROM node:20-alpine as vite-builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Etapa 2: Composer install
FROM composer:2 as composer-deps

WORKDIR /app
COPY . .
RUN composer install --optimize-autoloader --no-dev

# Etapa 3: Laravel + Caddy
FROM php:8.2-fpm-alpine

# Instalar dependencias
RUN apk add --no-cache bash curl git zip unzip icu-dev libxml2-dev \
    libpng-dev libjpeg-turbo-dev freetype-dev zlib-dev libzip-dev \
    oniguruma-dev caddy

RUN docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl intl gd

# Crear carpetas necesarias
RUN mkdir -p /var/www/html /run/php

# Copiar código desde etapas anteriores
COPY --from=composer-deps /app /var/www/html
COPY --from=vite-builder /app/public/build /var/www/html/public/build

# Copiar Caddy y script
COPY Caddyfile /etc/caddy/Caddyfile
COPY start.sh /start.sh
RUN chmod +x /start.sh

WORKDIR /var/www/html

CMD ["/start.sh"]
