#!/bin/sh
# ---------------------------------------------------
# Installation script for winmail.dat attachment files handler
# 
# Procedure :
#   http://www.bernaerts-nicolas.fr/linux/74-ubuntu/282-ubuntu-winmail-dat-thunderbird-nautilus
# ---------------------------------------------------

# install tools
sudo apt install tnef convmv

# install attachment extraction script 
sudo wget -O /usr/local/sbin/tnef-extract https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/mozilla/tnef/tnef-extract
sudo chmod +x /usr/local/sbin/tnef-extract

# declare desktop file
wget -O $HOME/.local/share/applications/tnef.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/mozilla/tnef/tnef.desktop
chmod +x $HOME/.local/share/applications/tnef.desktop

# declaration of new mime type in Nautilus
echo "[Added Associations]" >> $HOME/.local/share/applications/mimeapps.list
echo "application/ms-tnef=tnef.desktop;" >> $HOME/.local/share/applications/mimeapps.list

# declaration of new mime type in Thunderbird
wget -O $(ls $HOME/.thunderbird/*.default/mimeTypes.rdf) https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/mozilla/tnef/mimeTypes.rdf
