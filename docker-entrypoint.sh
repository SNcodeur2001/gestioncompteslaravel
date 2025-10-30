#!/bin/sh

echo "Waiting for database to be ready..."
while ! pg_isready -h $DB_HOST -p $DB_PORT -U $DB_USERNAME; do
  echo "Database is unavailable - sleeping"
  sleep 1
done

echo "Database is up - executing migrations"
php artisan migrate --force

echo "Fixing storage permissions"
chmod -R 775 storage

echo "Clearing and caching configuration for production"
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clearcurl -X 'POST' \
  'https://gestioncompteslaravel.onrender.com/api/v1/ndiaye.mapathe/auth/login' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'X-CSRF-TOKEN: ' \
  -H 'Accept: application/json' \
  -d '{
  "email": "admin@gestioncomptes.com",
  "password": "password"
}'

Request URL

https://gestioncompteslaravel.onrender.com/api/v1/ndiaye.mapathe/auth/login

Server response
Code	Details
500
Undocumented
	

Error: response status is 500
Response body

{
  "message": "Invalid key supplied",
  "exception": "LogicException",
  "file": "/var/www/html/vendor/league/oauth2-server/src/CryptKey.php",
  "line": 67,
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "Starting Laravel application..."
exec "$@"
