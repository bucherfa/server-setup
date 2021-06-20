# home server setup

## basic setup

### ubuntu

* hardware only worked with ubuntu network installer
* select `Basic Ubuntu Server` and `OpenSSH server` during installation in the `Software selection` section
* encrypt hard drive

### ssh

* add ssh keys to server
* disable login with password over ssh in `/etc/ssh/sshd_config`
* reload ssh serivce `sudo service ssh restart`

### docker setup

* install some software
* add ubuntu apt repo
* install docker-ce and docker-compose

```
sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
sudo apt update
sudo apt install docker-ce
sudo apt install docker-compose
sudo usermod -aG docker $USER #logout and login after this
```

### backup

The backup strategy heavily relies on [borgmatic](https://torsion.org/borgmatic/) which in turn relies on [Borg](https://www.borgbackup.org/). Follow the steps below to set it up.

* setup `borg >=1.0.8` and `rclone` on a remote system
  * for `borg` on ubuntu you need to add an additional [PPA](https://launchpad.net/~costamagnagianfranco/+archive/ubuntu/borgbackup)
    ```bash
    sudo add-apt-repository ppa:costamagnagianfranco/borgbackup
    sudo apt update
    sudo apt install borgbackup
    ```
  * for `rclone`
    ```bash
    sudo apt install rclone
    # if the version is too old, install via generic install script from https://rclone.org/downloads/
    ```
* setup rclone
  ```bash
  rclone config # and follow guided configuration
  # note: $NAME is used for rclone repo by default in backup.sh
  ```
* connect to the remote system at least once via ssh from your host machine to add it to `.ssh/know_hosts`
* create a folder on the remote system where the `borgmatic` repos should be initialized
* adjust the `.env` accordingly
* setup ssmtp for email notifications
  ```bash
  sudo apt install ssmtp
  # edit file /etc/ssmtp/ssmtp.conf and add the following content
  root=no-reply@domain.tld
  mailhub=mail.domain.tld:587
  hostname=no-reply@domain.tld
  FromLineOverride=YES
  UseSTARTTLS=YES
  AuthUser=no-reply@domain.tld
  AuthPass=secret
  # edit file /etc/ssmtp/revaliases and add the following content
  root:no-reply@domain.tld:mail.domain.tld:587
  user:no-reply@domain.tld:mail.domain.tld:587
  # test your configuration
  echo "Hello World!" | ssmtp cron@domain.tld
  ```
* setup a cron job for the backup script
  ```bash
  crontab -e
  # insert the following line to the end of the file
  # it writes the output first into a log file and then sends the output to a given mail address
  0 4 * * * cd /path/to/setup && ./backup.sh >> ./.logs/$(date -u +"\%Y-\%m-\%dT\%H:\%M:\%SZ").log && cat ./.logs/$(ls -t ./.logs | head -n1) | /usr/sbin/ssmtp cron@domain.tld
  ```

## notes

### list all images sorted by creation date

```bash
docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedAt}}\t{{.Size}}" | sort -k 4
```

### fritz.box

* blocks all domains mapped to local ip addresses by default

  to use domains in the local network add them to:

  `Home Network` > `Home Network Overview` > `Network Settings` > `DNS Rebind Protection`

## hardware

[PCPartPicker Part List](https://de.pcpartpicker.com/list/LMGFK4)

Type|Item|Price
:----|:----|:----
**CPU** | [AMD Ryzen 5 3400G 3.7 GHz Quad-Core Processor](https://de.pcpartpicker.com/product/XP6qqs/amd-ryzen-5-3400g-37-ghz-quad-core-processor-yd3400c5fhbox) | Purchased For €149.89
**CPU Cooler** | [Noctua NH-L9a-AM4 33.84 CFM CPU Cooler](https://de.pcpartpicker.com/product/DZfhP6/noctua-nh-l9a-am4-338-cfm-cpu-cooler-nh-l9a-am4) | Purchased For €41.10
**Memory** | [Crucial 8 GB (1 x 8 GB) DDR4-2666 Memory](https://de.pcpartpicker.com/product/2YdxFT/crucial-8gb-1-x-8gb-ddr4-2666-memory-ct8g4sfs8266) | Purchased For €31.54
**Memory** | [Crucial 8 GB (1 x 8 GB) DDR4-2666 Memory](https://de.pcpartpicker.com/product/2YdxFT/crucial-8gb-1-x-8gb-ddr4-2666-memory-ct8g4sfs8266) | Purchased For €31.54
**Storage** | [ADATA XPG SX6000 Pro 512 GB M.2-2280 NVME Solid State Drive](https://de.pcpartpicker.com/product/VwbwrH/adata-xpg-sx6000-pro-512-gb-m2-2280-solid-state-drive-asx6000pnp-512gt-c) | Purchased For €78.90
**Custom**| [ASRock Deskmini A300 AMD - Case, Motherboard, Power Supply](https://www.asrock.com/nettop/AMD/DeskMini%20A300%20Series/index.asp) | Purchased For €142.00
**Total** | | **€474.97**
