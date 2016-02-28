#!/bin/sh
# Image resize extension

# install packages
sudo apt-get -y install imagemagick

# main script
wget --header='Accept-Encoding:none' -O $HOME/.image-resize.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-resize.conf
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/image-resize https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-resize
sudo chmod +x /usr/local/bin/image-resize

# desktop integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/applications/image-resize.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-resize.desktop
sudo wget --header='Accept-Encoding:none' -O /usr/share/icons/image-resize.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-resize.png

# nautilus action
mkdir --parents $HOME/.local/share/file-manager/actions
wget --header='Accept-Encoding:none' -O $HOME/.local/share/file-manager/actions/image-resize-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-resize-action.desktop
