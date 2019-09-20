# Docker - Apache / PHP 7 / XDebug

This repository contains Docker image sources with following apps:

- Apache 2 (SSL supports)
- PHP 7 (with a lot of extensions: `pdo`, `intl`, `apc`, `mongo`, etc)
- Composer
- Supervisor

## Volumes

- Application: `/var/www/app`
- Workers: `/etc/supervisor.d`

## Environment

- CLI XDebug support: `PHP_IDE_CONFIG: serverName=localhost`
- Application hostname: `APP_NAME: dev.local`

## XDebug configuration

- IDE Key: `PHPSTORM`
- Port: `9000`
- *Requires path mapping