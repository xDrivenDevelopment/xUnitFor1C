#!/bin/sh
# This scripts is used to install dependencies

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update
sudo apt-get install -y -q x11vnc 
sudo apt-get install -y -q vnc4server
sudo apt-get install -y -q xvfb libwebkitgtk-1.0-0 language-pack-ru-base xfonts-cyrillic novnc
sudo apt-get install -y -q lxde ttf-ubuntu-font-family

sudo locale-gen ru_RU
sudo locale-gen ru_RU.UTF-8
sudo update-locale LANG=ru_RU.UTF-8

sudo dpkg -i /vagrant/dist/*common*.deb
sudo dpkg -i /vagrant/dist/*server*.deb
sudo dpkg -i /vagrant/dist/*client*.deb
sudo apt-get install -y -q -f

echo "copy config"
sudo mkdir -p /vagrant/build/log/logs && mkdir -p /vagrant/build/log/dumps && mkdir -p /vagrant/build/log/tsg
sudo cp /vagrant/externals/vagrant/conf /opt/1C/v8.3/x86_64/

#su vagrant

#mkdir ~/.vnc
#x11vnc -storepasswd 123456 ~/.vnc/passwd
#vncserver 

