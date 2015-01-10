#!/bin/sh
# Image levels optimize extension

sudo apt-get -y install imagemagick
sudo wget -O /usr/local/bin/image-level-optimize https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-level-optimize
sudo chmod +x /usr/local/bin/image-level-optimize
sudo wget -O /usr/share/icons/image-level-optimize.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-level-optimize.png
sudo wget -O /usr/share/applications/image-level-optimize.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-level-optimize.desktop
mkdir --parents $HOME/.local/share/file-manager/actions
wget -O $HOME/.local/share/file-manager/actions/image-level-optimize-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-level-optimize-action.desktop
