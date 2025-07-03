FROM caddy:2

# Copia el archivo de configuración de Caddy
COPY Caddyfile /etc/caddy/Caddyfile

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Copia todos los archivos del proyecto
COPY . .

# Expone el puerto 80 que Render detecta automáticamente
EXPOSE 80
