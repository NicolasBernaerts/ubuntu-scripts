#!/bin/sh
# Image levels optimize extension

# install packages
sudo apt-get -y install imagemagick

# main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/image-level-optimize https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-level-optimize
sudo chmod +x /usr/local/bin/image-level-optimize

# desktop integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/icons/image-level-optimize.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-level-optimize.png
#sudo wget --header='Accept-Encoding:none' -O /usr/share/applications/image-level-optimize.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-level-optimize.desktop

# nautilus action
mkdir --parents $HOME/.local/share/file-manager/actions
wget --header='Accept-Encoding:none' -O $HOME/.local/share/file-manager/actions/image-level-optimize-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-level-optimize-action.desktop
