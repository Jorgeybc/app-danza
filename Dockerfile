FROM php:8.2-fpm

# Instala dependencias del sistema
RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip curl git \
    && docker-php-ext-install pdo pdo_mysql zip

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Establece el directorio de trabajo
WORKDIR /var/www

# Copia archivos
COPY . .

# Instala dependencias de Laravel
RUN composer install --no-interaction --no-dev --prefer-dist

# Da permisos a storage y bootstrap
RUN chmod -R 775 storage bootstrap/cache

# Expone el puerto 8000
EXPOSE 8000

# Comando de inicio
CMD ["sh", "start.sh"]
