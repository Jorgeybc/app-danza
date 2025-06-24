# Etapa 1: Build de Vite
FROM node:18-alpine as vite-builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Etapa 2: Laravel con PHP-FPM
FROM php:8.2-fpm-alpine

RUN apk add --no-cache \
    bash zip unzip curl git \
    libpng libpng-dev libjpeg-turbo-dev freetype-dev \
    libxml2-dev oniguruma-dev zlib-dev icu-dev \
    libzip-dev mysql-client \
    && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl intl gd

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY . .

COPY --from=vite-builder /app/public/build ./public/build

RUN composer install --optimize-autoloader --no-dev

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]


