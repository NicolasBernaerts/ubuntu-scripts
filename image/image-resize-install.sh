#!/bin/sh
# Image resize extension

sudo apt-get -y install imagemagick
wget -O $HOME/.image-resize.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-resize.conf
sudo wget -O /usr/local/bin/image-resize https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-resize
sudo chmod +x /usr/local/bin/image-resize
sudo wget -O /usr/share/applications/image-resize.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-resize.desktop
mkdir --parents $HOME/.local/share/file-manager/actions
wget -O $HOME/.local/share/file-manager/actions/image-resize-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-resize-action.desktop
