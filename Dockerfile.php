FROM php:8.2-fpm

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y \
    unzip curl libzip-dev zip git npm nodejs \
    && docker-php-ext-install pdo pdo_mysql zip

# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Copia todos los archivos del proyecto
COPY . .

# Instala dependencias de PHP
RUN composer install --no-dev --optimize-autoloader

# Da permisos adecuados a Laravel
RUN chmod -R 775 storage bootstrap/cache

# Exponer FPM en el puerto 9000
EXPOSE 9000

# Ejecutar PHP-FPM
CMD ["php-fpm"]
