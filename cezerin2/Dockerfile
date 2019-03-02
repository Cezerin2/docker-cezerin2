FROM node:8
LABEL maintainer "Nitin Goyal <nitingoyal.dev@gmail.com>, Luke Busstra <luke.busstra@gmail.com>"

ENV NGINX_CODENAME stretch
ENV CEZERIN_VERSION 0.34.0
ENV API_PORT 3001

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
		nginx\
		nginx-module-image-filter

# install PM2
RUN npm install pm2 -g

# download project
RUN mkdir -p /var/www \
    && cd /var/www \
    && wget -O cezerin2.zip https://github.com/cezerin2/cezerin2/archive/v$CEZERIN_VERSION.zip \
    && unzip cezerin2.zip \
    && rm cezerin2.zip \
    && mv cezerin2-$CEZERIN_VERSION cezerin2

# overwrite PM2 process file
COPY process.json /var/www/cezerin2/

# Nginx config
RUN cd /var/www/cezerin2 \
	&& mv nginx/nginx.conf /etc/nginx/ \
	&& mv nginx/default.conf.template /etc/nginx/conf.d/

# script to run Nginx and PM2
RUN cd /var/www/cezerin2 \
	&& mv docker-entrypoint.sh /usr/local/bin/ \
	&& chmod +x "/usr/local/bin/docker-entrypoint.sh"

# build project
RUN cd /var/www/cezerin2 \
    && npm i

WORKDIR /var/www/cezerin2

EXPOSE 80

# start Nginx, PM2
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
