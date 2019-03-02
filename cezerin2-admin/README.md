# Supported tags and respective Dockerfile links

- ```0.34.0```, ```latest```
[(0.34.0/Dockerfile)](https://github.com/cezerin2/docker-cezerin2/blob/v0.34.0/cezerin2-admin/Dockerfile)


# What is Cezerin?
[Cezerin](https://github.com/cezerin2/cezerin2) is React and Node.js based eCommerce platform.

# How to use this image

### Start a cezerin2-admin server instance

#### With Port ***3002****

```shell
docker run -d \
--name admin \
-p 3002:80 \
cezerin2/cezerin2-admin:latest
```

### Environment variables

Name|Description|Default
-|-|-
`LANGUAGE`|Language|`en`
`API_BASE_URL`|API domain|`http://localhost:3001/api/v1`
`DEVELOPER_MODE`|Developer Mode|`true`

### Image contains

- **Node.js (8.10)** to run
ADMIN on **port 3002** .
- **Nginx (1.12.2)** as a reverse proxy admin. **Port 80**.
