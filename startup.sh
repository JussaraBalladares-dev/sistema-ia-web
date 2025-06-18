#!/bin/bash

# Copia la configuración personalizada de Nginx
cp /home/site/wwwroot/nginx_default.conf /etc/nginx/sites-available/default
service nginx reload

# Ejecuta comandos de Laravel (Opcional, pero recomendado en el primer despliegue o si haces cambios en BD/config)
cd /home/site/wwwroot

# Si no has incluido el directorio 'vendor' en tu ZIP
# composer install --no-dev --optimize-autoloader

php artisan key:generate --force # Solo si APP_KEY no está en las variables de entorno de Azure
php artisan migrate --force
php artisan storage:link # Si usas enlaces simbólicos para el almacenamiento
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan optimize:clear # Limpia cachés antiguas