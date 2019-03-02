# Supported tags

- ```0.33.0```, ```0.34.0```, ```latest```

#Supported Images

- [cezerin2 api](https://github.com/cezerin2/docker-cezerin2/blob/master/cezerin2/README.md)
- [cezerin2 admin](https://github.com/cezerin2/docker-cezerin2/blob/master/cezerin2-admin/README.md)
- [cezerin2 store](https://github.com/cezerin2/docker-cezerin2/blob/master/cezerin2-store/README.md)


# What is Cezerin?
[Cezerin](https://github.com/cezerin2/cezerin2) is React and Node.js based eCommerce platform.

# docker - How to use this images

### Start a mongo server instance

```shell
docker run -d \
--name store-db \
-v /var/www/store-db:/data/db \
mongo:latest
```

### Start a ceszerin2 server instance

```shell
docker run -d \
--name cezerin2 \
--link store-db:db \
-p 3001:80 \
-e DB_HOST=db \
-e DB_PORT=27017 \
-e DB_NAME=shop \
-e DB_USER=user \
-e DB_PASS=password \
-v /var/www/cezerin2/public/content:/var/www/cezerin2/public/content \
cezerin2/cezerin2:latest
```

### Start a ceszerin2 admin server instance

```shell
docker run -d \
--name cezerin2-admin \
--link cezerin2:cezerin2 \
-p 3002:80 \
-e API_BASE_URL=http://cezerin2/api/vi
cezerin2/cezerin2-admin:latest
```

### Start a ceszerin2 store server instance

```shell
docker run -d \
--name ceszerin2-store \
--link cezerin2:cezerin2 \
-p 3000:80 \
-e API_BASE_URL=http://cezerin2/api/v1 \ 
-e AJAX_BASE_URL=http://cezerin2/ajax \ 
cezerin2/cezerin2-store:latest
```

# docker compose - How to use this images

```shell
version: '3'

services:
  cezerin2:
    image: cezerin2/cezerin2
    ports:
      - 3001:80
    environment:
      - DB_HOST=db
      - DB_PORT=27017
      - DB_NAME=shop
      - DB_USER=user
      - DB_PASS=password
    volumes:
      - ./content:/var/www/cezerin2/public/content
    depends_on:
      - db
    restart: always

  cezerin2-store:
    image: cezerin2/cezerin2-store
    environment:
      - API_BASE_URL=http://cezerin2/api/v1
      - AJAX_BASE_URL=http://cezerin2/ajax
    ports:
      - 3000:80
    depends_on:
      - cezerin2
    restart: always

  admin:
    image: cezerin2/cezerin2-admin
    ports:
      - 3002:80
    depends_on:
      - cezerin2
    restart: always

  db:
    image: mongo:3.4
    ports:
      - 27017:27017
    volumes:
      - ./db:/data/db
    restart: always
```

### Access

localhost:3000
