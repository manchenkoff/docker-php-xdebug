# Docker - Apache / PHP 7 / XDebug

This repository contains Docker image sources with following apps:

- Apache 2 (SSL supports)
- PHP 7 (with a lot of extensions: `pdo`, `intl`, `apc`, `mongo`, etc)
- Composer
- Supervisor

## Volumes

- Application: `/var/www/app`
- Workers: `/etc/supervisor.d`
- Apache virtual hosts: `/etc/apache2/conf.d/hosts.conf`

## Environment

- CLI XDebug support: `PHP_IDE_CONFIG: serverName=localhost`
- XDebug hostname: `XDEBUG_CONFIG: remote_host=host.docker.internal` (if necessary)
- Application hostname: `APP_NAME: dev.local` (used as `ServerName` and default virtual host domain)

## XDebug configuration

- IDE Key: `PHPSTORM`
- Port: `9000`
- *Requires path mapping

## Example usage with `docker-compose`

```
version: "3.7"
services:
  php:
    image: manchenkoff/apache-php-xdebug
    container_name: php
    ports:
      - 80:80
      - 443:443
    volumes:
      - ./src/app:/var/www/app:cached
    environment:
      PHP_IDE_CONFIG: serverName=localhost
```

### Default Apache 2 hosts

File: `/etc/apache2/conf.d/hosts.conf`, You may do additional changes for your project

```
# HTTP section
<VirtualHost *:80>
    DocumentRoot "/var/www/app"
    ServerName {APP_NAME}
    ServerAdmin admin@{APP_NAME}

    <Directory "/var/www/app">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>

# HTTPS section
<VirtualHost *:443>
    DocumentRoot "/var/www/app"
    ServerName {APP_NAME}
    ServerAdmin admin@{APP_NAME}

    SSLEngine on
    SSLCertificateFile /etc/ssl/apache2/server.pem
    SSLCertificateKeyFile /etc/ssl/apache2/server.key

    <Directory "/var/www/app">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```