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

### edit `config/config.php`

```
# enter docker container and install an editor
docker-compose exec --user root app bash
apt update
apt install -y nano
# edit config file
nano config/config.php
```

### The reverse proxy header configuration is incorrect, or you are accessing Nextcloud from a trusted proxy.

add the following to your `config/config.php`.

```
  'trusted_proxies' => 
  array (
    0 => '172.23.0.0/24',
  ),
```

### requests are made to http

onlyoffice or grant access authentification try to run on http

add the following to your `config/config.php`.

```
  'overwriteprotocol' => 'https',
```
