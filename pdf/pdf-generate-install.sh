#!/bin/sh
# PDF generate extension

# if nautilus present, install nautilus-actions
command -v nautilus >/dev/null 2>&1 && sudo apt-get -y install nautilus-actions

# install configuration file 
mkdir --parents $HOME/.config
wget -O $HOME/.config/pdf-generate.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-generate.conf

# main packages installation
sudo apt-get -y install imagemagick unoconv ghostscript zenity libfile-mimeinfo-perl

# main script installation
sudo wget -O /usr/local/bin/pdf-generate https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-generate
sudo chmod +x /usr/local/bin/pdf-generate

# desktop integration
mkdir --parents $HOME/.local/share/file-manager/actions
wget -O $HOME/.local/share/file-manager/actions/pdf-generate-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-generate-action.desktop
