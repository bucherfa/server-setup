# home server setup

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

## basic setup

### ubuntu

* hardware only worked with ubuntu network installer
* select `Basic Ubuntu Server` and `OpenSSH server` during installation in the `Software selection` section
* encrypt hard drive

### first steps

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

## notes

### fritz.box

* blocks all domains mapped to local ip addresses by default

  to use domains in the local network add them to:

  `Home Network` > `Home Network Overview` > `Network Settings` > `DNS Rebind Protection`
