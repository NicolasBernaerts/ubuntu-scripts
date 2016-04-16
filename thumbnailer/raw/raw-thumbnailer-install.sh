#!/bin/sh
# RAW files thumbnailer

# install ufraw-batch
sudo apt-get install ufraw-batch

# thumbnailer integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/thumbnailers/raw.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/raw/raw.thumbnailer
