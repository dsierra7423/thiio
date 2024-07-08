#!/bin/sh

DB_HOST=db
DB_PORT=${DB_PORT:3306}
DB_USERNAME=${DB_USERNAME:root}
DB_PASSWORD=${DB_PASSWORD:password}
DB_DATABASE=${DB_DATABASE:laravel}


# Wait for MySQL to be ready
echo "Waiting for MySQL to be ready..."
until mysql -h "${DB_HOST}" -P "${DB_PORT}" -u "${DB_USERNAME}" -p"${DB_PASSWORD}" -e "SHOW DATABASES;" > /dev/null 2>&1; do
  echo "MySQL is unavailable - sleeping"
  sleep 3
done
echo "MySQL is up - executing command"


# Run migrations and seeds
php artisan migrate --force
php artisan db:seed --force

# Start PHP-FPM
#exec php-fpm