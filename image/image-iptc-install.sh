#!/bin/sh
# Image IPTC tag management extension

sudo apt-get -y install yad exiv2
sudo wget -O /usr/local/bin/image-iptc https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-iptc
sudo chmod +x /usr/local/bin/image-iptc
sudo wget -O /usr/share/applications/image-iptc.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-iptc.desktop
mkdir --parents $HOME/.local/share/file-manager/actions
wget -O $HOME/.local/share/file-manager/actions/image-iptc-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-iptc-action.desktop
