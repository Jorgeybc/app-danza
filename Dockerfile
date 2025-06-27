# Etapa base PHP
FROM php:8.2-fpm

# Instala extensiones necesarias
RUN apt-get update && apt-get install -y \
    nginx \
    unzip \
    curl \
    zip \
    git \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    && docker-php-ext-install pdo pdo_mysql zip

# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copia el código al contenedor
WORKDIR /var/www/html
COPY . .

# Instala dependencias de Laravel
RUN composer install --no-dev --optimize-autoloader

# Copia la configuración de Nginx
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Da permisos adecuados
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage

# Expone el puerto
EXPOSE 80

# Comando por defecto
CMD service php-fpm start && nginx -g 'daemon off;'
