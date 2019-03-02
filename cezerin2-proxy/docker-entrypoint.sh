#!/bin/sh
set -e

envsubst '${DOMAIN} ${STORE_HOST} ${ADMIN_HOST} ${API_HOST}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

nginx -g "daemon off;"
