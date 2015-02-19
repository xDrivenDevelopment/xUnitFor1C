#!/bin/sh
# This scripts is used to install dependencies

export DEBIAN_FRONTEND=noninteractive

echo "=========install VNC"
sudo apt-get update -qq
sudo apt-get install -y -qq x11vnc vnc4server
sudo apt-get install -y -qq xvfb libwebkitgtk-1.0-0 language-pack-ru-base xfonts-cyrillic novnc
sudo apt-get install -y -qq lxde lxde-core ttf-ubuntu-font-family ngrok-client wget zip curl unzip tar

sudo locale-gen ru_RU
sudo locale-gen ru_RU.UTF-8
sudo update-locale LANG=ru_RU.UTF-8

sudo dpkg -i /vagrant/distr/1c*common*.deb
sudo dpkg -i /vagrant/distr/1c*server*.deb
sudo dpkg -i /vagrant/distr/1c*client*.deb
sudo apt-get install -y -qq -f

echo "=========copy config"
sudo mkdir -p /vagrant/build/log/logs && mkdir -p /vagrant/build/log/dumps && mkdir -p /vagrant/build/log/tsg
sudo mkdir -p /opt/1C/v8.3/x86_64/conf

if test -f /opt/1C/v8.3/x86_64/1cestart; then 
	oneC_root=/opt/1C/v8.3/x86_64;
else 
	oneC_root=/opt/1C/v8.3/i386;
fi

sudo cp -R /vagrant/externals/vagrant/conf $oneC_root

echo "=========install noVNC"
# https://github.com/kanaka/noVNC/archive/v0.5.1.zip
cd /opt
wget --continue -O novnc.zip https://github.com/kanaka/noVNC/archive/v0.5.1.zip 
sudo unzip -q -o /opt/novnc.zip -d /opt/

# sudo service postgresql start
sudo service srv1cv83 start

