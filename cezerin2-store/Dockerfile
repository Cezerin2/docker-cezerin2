FROM node:8
LABEL maintainer "Nitin Goyal <nitingoyal.dev@gmail.com>, Luke Busstra <luke.busstra@gmail.com>"

ENV NGINX_CODENAME stretch
ENV CEZERIN_VERSION 0.34.0
ENV STORE_PORT 3000

# install requirements and NGINX
RUN echo "deb http://nginx.org/packages/debian/ ${NGINX_CODENAME} nginx" >> /etc/apt/sources.list \
	&& apt-get update && apt-get install --no-install-recommends --no-install-suggests -y --force-yes \
		gettext-base\
		bash \
		zip \
		unzip \
		wget \
		curl \
		nano \
		ca-certificates \
		nginx

# install PM2
RUN npm install pm2 -g

# download project
RUN mkdir -p /var/www \
    && cd /var/www \
    && wget -O cezerin2-store.zip https://github.com/cezerin2/cezerin2-store/archive/v$CEZERIN_VERSION.zip \
    && unzip cezerin2-store.zip \
    && rm cezerin2-store.zip \
    && mv cezerin2-store-$CEZERIN_VERSION cezerin

# Nginx config
RUN cd /var/www/cezerin \
	&& mv nginx/nginx.conf /etc/nginx/ \
	&& mv nginx/default.conf.template /etc/nginx/conf.d/ 

# script to run Nginx and PM2
RUN cd /var/www/cezerin \
	&& mv docker-entrypoint.sh /usr/local/bin/ \
	&& chmod +x "/usr/local/bin/docker-entrypoint.sh"

# build project
RUN cd /var/www/cezerin \
	&& npm install \
	&& npm cache clean --force \
	&& npm run build

WORKDIR /var/www/cezerin

EXPOSE 80

# start Nginx, PM2
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
