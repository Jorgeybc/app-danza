# Etapa 1: Build de Vite y dependencias
FROM node:18-alpine AS frontend

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Etapa 2: PHP y Laravel
FROM php:8.2-fpm-alpine

# Instalar dependencias de PHP
RUN apk add --no-cache \
    bash \
    zip \
    unzip \
    curl \
    libpng \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    oniguruma-dev \
    libxml2-dev \
    icu-dev \
    zlib-dev \
    libzip-dev \
    mysql-client \
    git \
    nodejs \
    npm \
    supervisor \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip intl

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY . .

RUN composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader

COPY --from=frontend /app/public/build ./public/build

# Permisos y cache
RUN chmod -R 775 storage bootstrap/cache

CMD ["php-fpm"]
