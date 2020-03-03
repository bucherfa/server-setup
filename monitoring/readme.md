# monitoring

![Architecture](architecture.png?raw=true)

## info

* made up out of three services, two running in docker containers and one plain on the system
* `telegraf` runs without docker on the system, it collects metrics and pushes them into `influxdb`
* `influxdb` is a database and collects data
* `grafana` is a webinterface to get an overview over the data, as well as sending alerts

## setup

* copy `example.env` to `.env`
* modify configuration, also update username and password in `telegraf.conf` for the `influxdb`
* install `telegraf`

```bash
wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/lsb-release
echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo apt update
sudo apt install telegraf
sudo cp /etc/telegraf/telegraf.conf /etc/telegraf/telegraf.conf.default
sudo cp ./telegraf.conf /etc/telegraf/telegraf.conf
sudo service telegraf reload
docker-compose up -d
```

* manually connect `grafana` to the `influxdb`
* import the `grafana` dashboard by copy and pasting

## update

* update `telegraf` through the system packages
* `grafana` and `influxdb` by running

```bash
docker-compose pull
docker-compose down
docker-compose up -d
```
