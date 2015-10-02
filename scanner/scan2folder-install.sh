#!/bin/sh
# scan2folder tool

# main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/scan2folder https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/scanner/scan2folder
sudo chmod +x /usr/local/bin/scan2folder

# configuration file 
wget --header='Accept-Encoding:none' -O $HOME/.scan2folder.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/scanner/scan2folder.conf

# desktop integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/applications/scan2folder.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/scanner/scan2folder.desktop
sudo chmod +x /usr/share/applications/scan2folder.desktop
