# Use an official PHP runtime as a parent image
FROM php:8.1-fpm-alpine

# Set the working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apk update && apk add --no-cache \
    git \
    curl \
    libpng-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev \
    oniguruma-dev \
    openssl-dev

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy composer.lock and composer.json
COPY composer.json ./

# Install project dependencies
RUN composer install

# Copy existing application directory contents
COPY . .

# Generate key for Laravel application
RUN php artisan key:generate

# Optimize Laravel application
RUN php artisan optimize

# Set permissions for Laravel storage and cache folders
RUN chown -R www-data:www-data \
    storage \
    bootstrap/cache

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]

