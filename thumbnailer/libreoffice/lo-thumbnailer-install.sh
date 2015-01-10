#!/bin/sh
# LibreOffice thumbnailer

sudo apt-get -y install libfile-mimeinfo-perl gvfs-bin unzip imagemagick
wget http://bernaerts.dyndns.org/download/gnome/thumbnailer/lo-thumbnailer-icons.zip
sudo unzip -d /usr/local/sbin lo-thumbnailer-icons.zip
rm lo-thumbnailer-icons.zip
sudo wget -O /usr/local/sbin/lo-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/libreoffice/lo-thumbnailer
sudo chmod +rx /usr/local/sbin/lo-thumbnailer
sudo wget -O /usr/share/thumbnailers/lo.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/libreoffice/lo.thumbnailer
