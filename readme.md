# Docker - Apache / PHP 7 / XDebug

This repository contains Docker image sources with following apps:

- Apache 2 (SSL supports)
- PHP 7 (with a lot of extensions: `pdo`, `intl`, `apc`, etc)
- Composer

## Volumes

- Application: `/var/www/app`
- Apache virtual hosts: `/etc/apache2/conf.d/hosts.conf`

## Environment

All params stay in `.env` file

- `HOST_NAME`: application name (URL, `default: localhost`)
- `XDEBUG_ENABLED`: load xdebug extension (`default: false`) 
- `XDEBUG_REMOTE_HOST`: remote address to process connections (`default: host.docker.internal`)
- `PHP_IDE_CONFIG`: server configuration for IDE (`example: serverName=localhost`)

## XDebug configuration

- Name: see `serverName` from `PHP_IDE_CONFIG` env param
- Host: `${HOST_NAME}`
- IDE Key: `PHPStorm`
- Port: `9000`
- *Requires path mapping

## Example usage with `docker-compose`

```
version: 3.7
services:
  php:
    image: manchenkoff/php-xdebug
    container_name: app
    ports:
      - 80:80
      - 443:443
    volumes:
      - ./src/app:/var/www/app:cached
    env_file:
      - .env
```

### Default Apache 2 hosts

File: `/etc/apache2/conf.d/hosts.conf`, You may do additional changes for your project

```
# HTTP section
<VirtualHost *:80>
    DocumentRoot "/var/www/app"
    ServerName {HOST_NAME}
    ServerAdmin admin@{HOST_NAME}

    <Directory "/var/www/app">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>

# HTTPS section
<VirtualHost *:443>
    DocumentRoot "/var/www/app"
    ServerName {HOST_NAME}
    ServerAdmin admin@{HOST_NAME}

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