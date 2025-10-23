#!/bin/bash

# Attendre que la base de données soit prête (si nécessaire)
# echo "Waiting for database..."
# while ! pg_isready -h $DB_HOST -p $DB_PORT -U $DB_USERNAME; do
#   sleep 1
# done
# echo "Database is ready!"

# Exécuter les migrations et seeders si en production
if [ "$APP_ENV" = "production" ]; then
    echo "Running migrations..."
    php artisan migrate --force
    echo "Running seeders..."
    php artisan db:seed --force
fi

# Générer la clé d'application si elle n'existe pas
if [ ! -f .env ]; then
    echo "Generating application key..."
    php artisan key:generate --force
fi

# Générer la documentation Swagger
echo "Generating Swagger documentation..."
php artisan l5-swagger:generate

# Démarrer PHP-FPM en arrière-plan
php-fpm &

# Démarrer Nginx
nginx -g 'daemon off;'