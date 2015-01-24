#!/bin/sh
# scan2folder tool

sudo wget -O /usr/local/bin/scan2folder https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/scan2folder/scan2folder
sudo chmod +x /usr/local/bin/scan2folder
sudo wget -O /usr/share/applications/scan2folder.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/scan2folder/scan2folder.desktop
sudo chmod +x /usr/share/applications/scan2folder.desktop
wget -O $HOME/.scan2folder.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/scan2folder/scan2folder.conf
