#!/bin/bash

# Use envsubst to replace environment variables in nginx.conf.template
envsubst '${NGINX_PORT} ${DOMAIN_NAME}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Start nginx in the foreground (daemon off)
exec nginx -g 'daemon off;'
