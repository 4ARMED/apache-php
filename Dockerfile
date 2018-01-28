FROM php:7-apache
LABEL maintainer="Marc Wickenden <marc@4armed.com>"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq libyaml-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
	net-tools \
	netcat-traditional \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo pdo_mysql \
    && rm -rf /var/lib/apt/lists/*

COPY apache.conf /etc/apache2/sites-available/000-default.conf
COPY php.ini /usr/local/etc/php/

RUN mkdir -p /app/public

EXPOSE 80
