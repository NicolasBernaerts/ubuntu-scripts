#!/bin/sh
# Image rotation nautilus extension
# Uses Nautilus and Python3 wrapper

# main packages installation
sudo apt update
sudo apt -y install python3-nautilus
sudo apt -y install libfile-mimeinfo-perl libjpeg-turbo-progs netpbm
sudo apt -y install xdg-utils imagemagick dcraw libheif-examples

# remove files from previous version
sudo rm --force /usr/share/file-manager/actions/image-resize.desktop
sudo rm --force /usr/share/file-manager/actions/image-resize-*.desktop
rm --force $HOME/.local/share/file-manager/actions/image-resize-*.desktop

# show icon in menus (command different according to gnome version)
gsettings set org.gnome.desktop.interface menus-have-icons true
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/ButtonImages': <1>, 'Gtk/MenuImages': <1>}"

# install icons
sudo wget -O /usr/share/icons/image-resize.png https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/icon/image/image-resize.png

# main script installation
sudo wget -O /usr/local/bin/image-convert https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-convert
sudo chmod +x /usr/local/bin/image-convert

# desktop integration
mkdir --parents $HOME/.local/share/nautilus-python/extensions
wget -O $HOME/.local/share/nautilus-python/extensions/image-resize-menu.py https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-resize-menu.py
