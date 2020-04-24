# nextcloud

![Architecture](architecture.png?raw=true)

## issues

### run occ task

```
docker-compose exec --user www-data app php occ <task>
```

### Please run mysql_upgrade

```
docker-compose exec db bash
mysql_upgrade -p
# fill password prompt
# ctl + d to exit
```
