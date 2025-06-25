# Etapa 1: Build de Vite
FROM node:20-alpine as vite-builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build


# Etapa 2: Instalar dependencias PHP con Composer
FROM composer:2 as composer-deps

WORKDIR /app
COPY . .
RUN composer install --optimize-autoloader --no-dev


# Etapa 3: PHP-FPM con Laravel
FROM php:8.2-fpm-alpine

# Instalar dependencias del sistema
RUN apk add --no-cache \
    bash zip unzip curl git \
    libpng libpng-dev libjpeg-turbo-dev freetype-dev \
    libxml2-dev oniguruma-dev zlib-dev icu-dev \
    libzip-dev mysql-client \
    && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl intl gd

# Copiar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Crear y entrar al directorio de la app
WORKDIR /var/www/html

# Copiar código desde etapa composer
COPY --from=composer-deps /app .

# Copiar assets generados por Vite
COPY --from=vite-builder /app/public/build ./public/build

# Copiar script de arranque
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Establecer permisos
RUN chown -R www-data:www-data /var/www/html

CMD ["/start.sh"]
