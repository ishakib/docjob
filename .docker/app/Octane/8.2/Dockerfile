FROM php:8.2-cli-alpine

ARG SERVER_ENVIRONMENT

RUN set -ex \
  && apk --no-cache add \
    postgresql-dev

# Add Repositories
RUN rm -f /etc/apk/repositories &&\
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.18/main" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.18/community" >> /etc/apk/repositories

# fix work iconv library with alpine
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

# Add Build Dependencies
RUN apk update && apk add --no-cache  \
    libzip-dev \
    libmcrypt-dev \
    libjpeg-turbo-dev \
    libjpeg-turbo \
    jpeg-dev \
    libpng-dev \
    libxml2-dev \
    bzip2-dev \
    libwebp-dev \
    zip \
    jpegoptim \
    pngquant \
    optipng \
    icu-dev \
    freetype-dev \
    libpq \
    zlib-dev \
    curl-dev \
    imap-dev \
    git \
    vim \
    openssl-dev \
    pcre-dev  \
    pcre2-dev \
    linux-headers

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

RUN docker-php-ext-configure pcntl --enable-pcntl \
  && docker-php-ext-install pcntl
#RUN docker-php-ext-configure imap

# Configure & Install Extension
RUN docker-php-ext-configure \
    opcache --enable-opcache &&\
    docker-php-ext-configure zip && \
    docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && \
    docker-php-ext-install -j "$(nproc)" \
    opcache \
    pdo \
    pdo_pgsql \
    pgsql

RUN CFLAGS="$CFLAGS -D_GNU_SOURCE" docker-php-ext-install sockets

RUN apk add --update --no-cache autoconf g++ make \
&& pecl install redis \
&&  docker-php-ext-enable redis

RUN pecl install swoole-5.1.1 && docker-php-ext-enable swoole
# Add Composer
RUN curl -sS https://getcomposer.org/installer | \
php -- --install-dir=/usr/bin/ --filename=composer
#RUN composer install  --no-interaction --optimize-autoloader --no-dev --prefer-dist

COPY .docker/app/Octane/8.2/opcache.ini $PHP_INI_DIR/conf.d/
COPY .docker/app/Octane/8.2/php.ini $PHP_INI_DIR/conf.d/


# Setup Working Dir
WORKDIR /var/www/app

COPY .docker/app/Octane/8.2/octane-init.sh /usr/local/bin
RUN chmod +x /usr/local/bin/octane-init.sh

EXPOSE 8000