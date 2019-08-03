#!/bin/sh
# Removal of ImageMagick PDF and PostScript restrictions 

# main script
sudo wget -O /usr/local/bin/imagemagick-enable-pdf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/imagemagick-enable-pdf
sudo chmod +x /usr/local/bin/imagemagick-enable-pdf

# run the script
/usr/local/bin/imagemagick-enable-pdf

# apt hook
sudo wget -O /etc/apt/apt.conf.d/99imagemagick-enable-pdf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/99imagemagick-enable-pdf
