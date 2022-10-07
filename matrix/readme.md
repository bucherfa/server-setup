# matrix

![Architecture](architecture.png?raw=true)

## Maintenance

| [Docs](https://github.com/matrix-org/synapse/tree/develop/contrib/docker) | [Releases](https://github.com/matrix-org/synapse/releases) |
| --- | --- |

### Updating

nothing speacial

```bash
docker-compose pull
docker-compose down
docker-compose up -d
```

### Check Version

```
curl https://<domain.tld>/_matrix/federation/v1/version
```

## Setup

for delegation use `caddy`.

setup reverse proxy for port 8448 in `traefik`
