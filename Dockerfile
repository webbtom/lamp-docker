FROM php:8.2-apache

# Install dependencies and PHP extensions
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y libzip-dev zip nano curl npm && \
    docker-php-ext-install pdo pdo_mysql && \
    pecl install xdebug && docker-php-ext-enable xdebug && \
    apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) gd && \
    docker-php-ext-install zip

# Enable Apache mod_rewrite for URL rewriting
RUN a2enmod rewrite

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql zip

# Configure Apache DocumentRoot to point to Laravel's public directory
# and update Apache configuration files
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Install Composer
COPY --from=composer/composer:latest-bin /composer /usr/bin/composer

# Set the COMPOSER_ALLOW_SUPERUSER environment variable
ENV COMPOSER_ALLOW_SUPERUSER 1

# Set the working directory
WORKDIR /var/www/html

## Install project dependencies
#RUN composer install
#
## Set permissions
#RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
