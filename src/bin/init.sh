#!/bin/sh

# /usr/local/bin/init

# Replace env params in config files
sed -i "s/{HOST_NAME}/${HOST_NAME}/g" /etc/apache2/httpd.conf
sed -i "s/{HOST_NAME}/${HOST_NAME}/g" /etc/apache2/conf.d/hosts.conf
sed -i "s/{XDEBUG_REMOTE_HOST}/${XDEBUG_REMOTE_HOST}/g" /etc/php7/conf.d/xdebug.ini

# Set up xdebug
if [ ${XDEBUG_ENABLED} = true ] ; then
  sed -i "s/;zend_extension/zend_extension/g" /etc/php7/conf.d/xdebug.ini
fi

# Start container with Apache web server as a main process
current_date=$(date +'%d.%m.%Y %r')

printf "${current_date} - Container: Apache 2 / PHP 7.4 / XDebug \n\n"
printf "Server: ${HOST_NAME} \n\n"

exec /usr/sbin/httpd -D FOREGROUND