FROM node:8
LABEL maintainer "Nitin Goyal <nitingoyal.dev@gmail.com>, Luke Busstra <luke.busstra@gmail.com>"

ENV NGINX_CODENAME stretch
ENV CEZERIN_VERSION 0.34.0

# install requirements and NGINX
RUN echo "deb http://nginx.org/packages/debian/ ${NGINX_CODENAME} nginx" >> /etc/apt/sources.list \
	&& apt-get update && apt-get install --no-install-recommends --no-install-suggests -y --force-yes \
		bash \
		zip \
		unzip \
		wget \
		curl \
		nano \
		ca-certificates \
		nginx

# download project
RUN mkdir -p /var/www \
    && cd /var/www \
    && wget -O cezerin2-admin.zip https://github.com/cezerin2/cezerin2-admin/archive/v$CEZERIN_VERSION.zip \
    && unzip cezerin2-admin.zip \
    && rm cezerin2-admin.zip \
    && mv cezerin2-admin-$CEZERIN_VERSION cezerin2-admin

# Nginx config
RUN cd /var/www/cezerin2-admin \
	&& mv nginx/nginx.conf /etc/nginx/ \
	&& mv nginx/default.conf /etc/nginx/conf.d/

# script to run Nginx and PM2
RUN cd /var/www/cezerin2-admin \
	&& cp ./docker-entrypoint.sh /usr/local/bin/ \
	&& chmod +x "/usr/local/bin/docker-entrypoint.sh"

# build project
RUN cd /var/www/cezerin2-admin \
	&& npm install \
	&& npm cache clean --force \
	&& npm run build

WORKDIR /var/www/cezerin2-admin

EXPOSE 80

# start env build and Nginx
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

