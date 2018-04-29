#!/bin/sh
# RAW files thumbnailer

# install tools
sudo apt-get -y install dcraw libjpeg-turbo-progs netpbm

# install main script
sudo wget -O /usr/local/sbin/raw-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/raw/raw-thumbnailer
sudo chmod +x /usr/local/sbin/raw-thumbnailer

# thumbnailer integration
sudo wget -O /usr/share/thumbnailers/raw.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/raw/raw.thumbnailer

# stop nautilus
nautilus -q

# empty cache of previous thumbnails
[ -d "$HOME/.cache/thumbnails" ] && rm --recursive --force $HOME/.cache/thumbnails/*
[ -d "$HOME/.thumbnails" ] && rm --recursive --force $HOME/.thumbnails/*
