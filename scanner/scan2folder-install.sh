#!/bin/sh
# scan2folder tool

# install tools
sudo apt -y install ghostscript yad hplip-gui

# main script
sudo wget -O /usr/local/bin/scan2folder https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/scanner/scan2folder
sudo chmod +x /usr/local/bin/scan2folder

# configuration file
mkdir --parent $HOME/.config
wget -O $HOME/.config/scan2folder.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/scanner/scan2folder.conf

# desktop integration
sudo wget -O /usr/share/applications/scan2folder.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/scanner/scan2folder.desktop
sudo chmod +x /usr/share/applications/scan2folder.desktop
