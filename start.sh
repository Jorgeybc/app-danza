#!/bin/sh

echo "▶️ Iniciando aplicación Laravel..."

# Esperar a que la base de datos esté disponible
until nc -z "$DB_HOST" "$DB_PORT"; do
  echo "⏳ Esperando a la base de datos... (intento $i)"
  i=$((i+1))
  sleep 2
done

echo "✅ Base de datos disponible. Ejecutando migraciones..."
php artisan migrate --force

echo "🧠 Cacheando configuración..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "🚀 Iniciando supervisord..."
supervisord -c /etc/supervisord.conf &

# 🧾 Esperar un poco y mostrar log de error de nginx
sleep 2
echo "📄 Mostrando últimos errores de NGINX..."
cat /var/log/nginx/error.log || echo "❌ No se pudo leer el log de nginx"

# Mantener el contenedor vivo
tail -f /dev/null
