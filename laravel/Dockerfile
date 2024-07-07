# laravel/Dockerfile
FROM php:8.1-fpm-alpine

# Install necessary extensions
RUN docker-php-ext-install pdo pdo_mysql

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy the composer files
COPY . composer.json ./

RUN mkdir -p ./database/seeders
RUN mkdir -p ./database/factories

# Install dependencies
RUN composer install

# Copy the rest of the application code
COPY . .

# Expose port
EXPOSE 9000

# Entry point to run migrations and start PHP-FPM
CMD php artisan migrate --force && php artisan db:seed --force && php-fpm
