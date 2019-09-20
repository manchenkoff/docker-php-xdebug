#!/bin/sh

# /usr/local/bin/init

cd /root

# Start supervisor process and stop workers by default
supervisord -c /etc/supervisord.conf
supervisorctl stop all @> /dev/null

# Start container with Apache web server as a main process
current_date=$(date +'%d.%m.%Y %r')

printf "${current_date} - Container: Apache 2 / PHP 7 / Composer / XDebug / Supervisor \n\n"
printf "Server: ${APP_NAME} \n\n"

exec /usr/sbin/httpd -D FOREGROUND