#!/bin/sh
# ---------------------------------------------------
# Installation script for automatic mount
#  of Toshiba FlashAir SD Cards under Ubuntu
# 
# Procedure :
#   http://bernaerts.dyndns.org/linux/76-gnome/xxx
#
# Card will be mounted under /media/flashair
# If you change this directory, please update
#   flashair.conf and flashair.desktop files
# ---------------------------------------------------

# install inotifywait tool and imagemagick
sudo apt install inotify-tools imagemagick

# install configuration file and set current user
sudo wget -O /etc/flashair.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/flashair/flashair.conf
sudo sed -i "s/#USER#/$USER/g" /etc/flashair.conf

# download icons
sudo wget -O /usr/share/icons/flashair-icon.png https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/flashair/flashair-icon.png
sudo wget -O /usr/share/icons/flashair-generic.jpg https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/flashair/flashair-generic.jpg
sudo wget -O /usr/share/icons/flashair-available.png https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/flashair/flashair-available.png
sudo wget -O /usr/share/icons/flashair-download.png https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/flashair/flashair-download.png

# download main scripts
sudo wget -O /usr/local/sbin/flashair-daemon https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/flashair/flashair-daemon
sudo wget -O /usr/local/sbin/flashair-command https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/flashair/flashair-command
sudo wget -O /usr/local/sbin/flashair-network https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/flashair/flashair-network
sudo chmod +x /usr/local/sbin/flashair-daemon /usr/local/sbin/flashair-command /usr/local/sbin/flashair-network

# install network setup script
sudo ln -s /usr/local/sbin/flashair-network /etc/network/if-up.d/flashair-network
sudo ln -s /usr/local/sbin/flashair-network /etc/network/if-post-down.d/flashair-network

# declare nautilus action
wget -O $HOME/.local/share/file-manager/actions/flashair-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/flashair/flashair-action.desktop

# restart networking services
sudo service networking restart
