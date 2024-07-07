# Dockerfile
FROM php:8.1-fpm-alpine

# Install necessary packages
RUN apk add --no-cache \
    git \
    mysql-client \
    icu-libs \
    icu-dev \
    oniguruma-dev \
    libzip-dev \
    zip \
    unzip \
    bash \
    nginx \
    supervisor

# Install PHP extensions
RUN docker-php-ext-install \
    pdo_mysql \
    intl \
    mbstring \
    bcmath \
    opcache \
    zip

# Set working directory
WORKDIR /var/www

# Copy existing application directory contents
COPY . /var/www

# Install Composer
COPY --from=composer:2.1 /usr/bin/composer /usr/bin/composer

# Install application dependencies
RUN composer install --no-dev --optimize-autoloader

# Ensure www-data can write to necessary directories
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Copy nginx and supervisor configurations
COPY .docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY .docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose port 80
EXPOSE 80

# Start supervisord
CMD php artisan migrate --force && php artisan db:seed --force && /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
