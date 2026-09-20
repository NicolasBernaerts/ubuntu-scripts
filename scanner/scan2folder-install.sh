#!/bin/sh
# scan2folder tool

# install tools
sudo apt -y install ghostscript yad hplip-gui

# main script
sudo wget -4 -O /usr/local/bin/scan2folder https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/scanner/scan2folder
sudo chmod +x /usr/local/bin/scan2folder

# configuration file
mkdir --parent $HOME/.config
wget -4 -O $HOME/.config/scan2folder.conf https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/scanner/scan2folder.conf

# desktop integration
sudo wget -4 -O /usr/share/applications/scan2folder.desktop https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/scanner/scan2folder.desktop
sudo chmod +x /usr/share/applications/scan2folder.desktop
