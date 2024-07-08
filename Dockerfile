FROM php:fpm-alpine

# Copy composer.lock and composer.json
COPY composer.lock composer.json /var/www/

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apk --no-cache add \
    build-base \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    zip \
    jpegoptim \
    optipng \
    pngquant \
    gifsicle \
    vim \
    unzip \
    git \
    curl \
    oniguruma-dev \
    libzip-dev \
    gd-dev \
    shadow \
    bash \
    icu-dev \
    mysql-client

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
COPY . /var/www

WORKDIR "/var/www"

#RUN chmod +x ./docker-composer.sh 
#RUN ./docker-composer.sh

#RUN composer install && \
#    php artisan key:generate

# Create the www group and user
RUN addgroup -g 1000 www && \
    adduser -u 1000 -D -S -G www -s /bin/bash www

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install pdo_mysql zip exif pcntl gd intl


# Copy entrypoint script
#COPY ./docker-entrypoint.sh /usr/local/bin/
#RUN chmod +x /usr/local/bin/docker-entrypoint.sh
#ENTRYPOINT ["docker-entrypoint.sh"]

#RUN chmod +x ./docker-composer.sh && \
#    chown www:www ./docker-composer.sh
#RUN ./docker-composer.sh

COPY --chown=www:www . /var/www

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["composer install" , "php artisan key:generate" ,"php-fpm"]