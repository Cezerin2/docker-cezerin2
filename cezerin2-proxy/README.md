# Supported tags and respective Dockerfile links

- ```0.34.0```, ```latest```
[(0.34.0/Dockerfile)](https://github.com/cezerin2/docker-cezerin2/blob/v0.34.0/cezerin2-proxy/Dockerfile)


# What is Cezerin?
[Cezerin](https://github.com/cezerin2/cezerin2) is React and Node.js based eCommerce platform.

# Docker - How to use this image

### Start a cezerin2-admin server instance

#### With Port ***80****

```shell
docker run -d \
--name proxy \
-p 80:80 \
-e DOMAIN=example.com \
-e API_HOST=localhost:3001 \
-e STORE_HOST=localhost:3000 \
-e ADMIN_HOST=localhost:3002 \
cezerin2/cezerin2-proxy:latest
```

# Docker Compose - How to use this image

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
      - STORE_URL=http://www.example.com
      - ADMIN_BASE_URL=http://admin.example.com
      - ASSETS_BASE_URL=http://api.example.com
    volumes:
      - ./content:/var/www/cezerin2/public/content
    depends_on:
      - db
    restart: always

  cezerin2-store:
    image: cezerin2/cezerin2-store
    environment:
      - API_BASE_URL=http://api.example.com/api/v1
      - AJAX_BASE_URL=http://api.example.com/ajax
    ports:
      - 3000:80
    depends_on:
      - cezerin2
    restart: always

  cezerin2-admin:
    image: cezerin2/cezerin2-admin
    environment:
      - API_BASE_URL=http://api.example.com/api/v1
    ports:
      - 3002:80
    depends_on:
      - cezerin2
    restart: always

  cezerin2-proxy:
    image: cezerin2/cezerin2-proxy
    environment:
      - DOMAIN=example.com
      - API_HOST=cezerin2
      - STORE_HOST=cezerin2-store
      - ADMIN_HOST=cezerin2-admin
    ports:
      - 80:80
    depends_on:
      - cezerin2
      - cezerin2-store
      - cezerin2-admin
    restart: always

  db:
    image: mongo:3.6
    ports:
      - 27017:27017
    volumes:
      - ./db:/data/db
    restart: always
```

### Environment variables

Name|Description|Default
-|-|-
`DOMAIN`|Language|
`API_HOST`|API Host|
`STORE_HOST`|Store Host|
`ADMIN_HOST`|Admin Host|

### Image contains

- **Nginx (1.12.2)** as a reverse proxy Store at domain.com, admin at admin.domain.com and api at api.domain.com. **Port 80**.
