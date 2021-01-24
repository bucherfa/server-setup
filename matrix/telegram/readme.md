# mautrix-telegram

## Setup

```
# generate config file
docker-compose run mautrix-telegram
# edit config.yaml
# adjust adress, domain, appservice.address (mautrix-telegram:port), api_id, api_hash, bridge.permission, e2be (set true), database (set to postgres)
docker run -ti --rm -v telegram_data:/data ubuntu bash
# run again to generate registration file
docker-compose run mautrix-telegram
# if not already there, enable bridge in matrix config file
# app_service_config_files: ["/path/to/your/mautrix-telegram/registration.yaml"]
# start 
```

# Update

manually edit to the newest stable version, watch out for the `v`

```
# edit version number in docker-compose.yml
docker-compose down
docker-compose up -d
```
