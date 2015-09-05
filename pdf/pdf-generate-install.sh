#!/bin/sh
# PDF generate extension

sudo apt-get -y install imagemagick unoconv ghostscript zenity libfile-mimeinfo-perl
sudo wget -O /usr/local/bin/pdf-generate https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-generate
sudo chmod +x /usr/local/bin/pdf-generate
mkdir --parents $HOME/.local/share/file-manager/actions
wget -O $HOME/.local/share/file-manager/actions/pdf-generate-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-generate-action.desktop
