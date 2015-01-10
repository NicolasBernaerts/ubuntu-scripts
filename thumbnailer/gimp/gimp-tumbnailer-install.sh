#!/bin/sh
# GIMP XCF thumbnailer

sudo apt-get -y install gvfs-bin imagemagick xcftools
sudo wget -O /usr/local/sbin/gimp-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/gimp/gimp-thumbnailer
sudo chmod +x /usr/local/sbin/gimp-thumbnailer
sudo wget -O /usr/share/thumbnailers/gimp.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/gimp/gimp.thumbnailer
