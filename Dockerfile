# Etapa 1: Construcción de assets con Node.js
FROM node:18 AS build

WORKDIR /app

# Copia archivos necesarios para compilar assets
COPY package.json vite.config.js tailwind.config.js postcss.config.cjs ./

COPY resources ./resources

RUN npm install && npm run build

# Etapa 2: Imagen base PHP-FPM
FROM php:8.2-fpm

# Instala dependencias del sistema
RUN apt-get update && apt-get install -y \
    curl zip unzip git libzip-dev libpng-dev libonig-dev \
    && docker-php-ext-install pdo pdo_mysql zip

# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Copia el proyecto completo
COPY . .

# Copia los assets compilados desde el build
COPY --from=build /app/public ./public

# Da permisos adecuados
RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# Instala dependencias PHP sin dev
RUN composer install --no-dev --optimize-autoloader
