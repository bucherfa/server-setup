# outline

![Architecture](architecture.png?raw=true)

## Maintenance

| [Docs](https://app.getoutline.com/s/770a97da-13e5-401e-9f8a-37949c19f97e/doc/docker-7pfeLP5a8t) | [Releases](https://github.com/outline/outline/releases) |
| --- | --- |

### Updating

nothing special

```bash
# update version numbers in docker-compose.yml
docker-compose pull
docker-compose down
docker-compose up -d
```

maybe the database has to be migrated

```bash
docker-compose run --rm outline yarn db:migrate --env=production-ssl-disabled
```

## Setup

1. prepare an OIDC auth provider (Nextcloud with [OIDC Identity Provider](https://apps.nextcloud.com/apps/oidc) for example)
1. fill out `.env` (everything except the S3 variables)
2. create and migrate the postgres database
    ```bash
    docker-compose run --rm outline yarn db:create --env=production-ssl-disabled
    docker-compose run --rm outline yarn db:migrate --env=production-ssl-disabled
    ```
3. start the containers
    ```bash
    docker-compose up -d
    ```
4. login to the minio console/admin interface
5. create a user with read/write permission
6. create a bucket
    * with [additional access rules](https://github.com/outline/outline/discussions/2765#discussioncomment-2210789) with access `readonly` and the prefixes `avatars` and `public`
7. update the `.env`
8. restart the containers
    ```bash
    docker-compose down
    docker-compose up -d
    ```

### Links

* [Reference Setup](https://github.com/vicalloy/outline-docker-compose/)
* [Which S3 Environment Variables to set for minio](https://github.com/outline/outline/discussions/3437)
* [Future consideration: replace manual minio setup with minio client](https://hub.docker.com/r/minio/mc/)
