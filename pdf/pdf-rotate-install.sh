#!/bin/sh
# Install PDF rotate extension
# Uses Nautilus and Python3 wrapper

# remove files from previous version
[ -f "/usr/share/applications/pdf-rotate.desktop" ] && sudo rm "/usr/share/applications/pdf-rotate.desktop"
sudo rm --force /usr/share/applications/pdf-rotate-*.desktop
rm --force $HOME/.local/share/file-manager/actions/pdf-rotate-*.desktop

# main packages installation
sudo apt update
sudo apt -y install python3-nautilus
sudo apt -y install texlive-extra-utils

# show icon in menus (command different according to gnome version)
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/ButtonImages': <1>, 'Gtk/MenuImages': <1>}"

# install icons
sudo wget -O /usr/share/icons/pdf-rotate.png https://github.com/NicolasBernaerts/icon/blob/master/pdf/pdf-rotate.png
sudo wget -O /usr/share/icons/rotate-left.png https://github.com/NicolasBernaerts/icon/blob/master/rotation/rotate-left.png
sudo wget -O /usr/share/icons/rotate-right.png https://github.com/NicolasBernaerts/icon/blob/master/rotation/rotate-right.png
sudo wget -O /usr/share/icons/rotate-updown.png https://github.com/NicolasBernaerts/icon/blob/master/rotation/rotate-updown.png

# main script installation
sudo wget -O /usr/local/bin/pdf-rotate https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/pdf/pdf-rotate
sudo chmod +x /usr/local/bin/pdf-rotate

# desktop integration
mkdir --parents $HOME/.local/share/nautilus-python/extensions
wget -O $HOME/.local/share/nautilus-python/extensions/pdf-rotate-menu.py https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/pdf/pdf-rotate-menu.py

