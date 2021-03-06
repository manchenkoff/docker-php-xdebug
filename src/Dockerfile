FROM alpine:3.12

# Upgrade default packages
RUN apk update && apk upgrade

# Set application name
ENV HOST_NAME=localhost

# Set xdebug params
ENV XDEBUG_ENABLED=false
ENV XDEBUG_REMOTE_HOST=host.docker.internal
ENV PHP_IDE_CONFIG="serverName=${HOST_NAME}"

# Set custom time zone info
ENV TZ=Europe/Moscow
RUN apk add --no-cache tzdata

# Install Apache 2 web server
RUN apk add --no-cache apache2 apache2-ssl
RUN rm -R /var/www/localhost

# Install PHP 7.4
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    php7 php7-pear php7-dev php7-apache2 \
    php7-pdo php7-pdo_mysql php7-pdo_pgsql php7-pdo_sqlite \
    php7-mbstring php7-tokenizer php7-xml php7-simplexml \
    php7-zip php7-opcache php7-iconv php7-intl php7-pcntl \
    php7-json php7-gd php7-ctype php7-pecl-oauth php7-pecl-xdebug \
    php7-pecl-redis php7-pecl-apcu php7-pecl-imagick php7-dom \
    php7-pecl-memcached php7-ftp php7-imap php7-xmlwriter \
    php7-exif php7-sqlite3 php7-curl php7-bcmath

# Web server configuration
COPY ./apache/httpd.conf /etc/apache2/httpd.conf
COPY ./apache/ssl.conf /etc/apache2/conf.d/ssl.conf
COPY ./apache/hosts.conf /etc/apache2/conf.d/hosts.conf

# PHP Configuration
COPY ./php/php.ini /etc/php7/php.ini
COPY ./php/xdebug.ini /etc/php7/conf.d/xdebug.ini

# Symlinks to see Apache logs
RUN ln -s /dev/stdout /var/www/logs/access.log
RUN ln -s /dev/stderr /var/www/logs/error.log

# Container initialization script
COPY ./bin/init.sh /usr/local/bin/init

# Open network ports
EXPOSE 80 443

# Copy default app sources
COPY ./app /var/www/app

VOLUME ["/var/www/app"]
WORKDIR /var/www/app

ENTRYPOINT ["init"]