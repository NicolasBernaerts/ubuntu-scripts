#!/bin/sh
# Ms Office thumbnailer

sudo apt-get -y install libfile-mimeinfo-perl gvfs-bin unoconv imagemagick
wget http://bernaerts.dyndns.org/download/gnome/thumbnailer/msoffice-thumbnailer-icons.zip
sudo unzip -d /usr/local/sbin msoffice-thumbnailer-icons.zip
rm msoffice-thumbnailer-icons.zip
sudo wget -O /usr/local/sbin/msoffice-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/msoffice/msoffice-thumbnailer
sudo chmod +rx /usr/local/sbin/msoffice-thumbnailer
sudo wget -O /usr/share/thumbnailers/msoffice.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/msoffice/msoffice.thumbnailer
