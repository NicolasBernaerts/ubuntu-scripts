#!/bin/sh
# Image IPTC tag management extension

# install tools
sudo apt-get -y install yad exiv2

# install script
sudo wget -4 -O /usr/local/bin/image-iptc https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/image/image-iptc
sudo chmod +x /usr/local/bin/image-iptc

# install desktop environment
sudo wget -4 -O /usr/share/applications/image-iptc.desktop https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/image/image-iptc.desktop
mkdir --parents $HOME/.local/share/file-manager/actions
wget -4 -O $HOME/.local/share/file-manager/actions/image-iptc-action.desktop https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/image/image-iptc-action.desktop
