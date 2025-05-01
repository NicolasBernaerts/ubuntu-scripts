#!/bin/sh
# Install Image rotation extension
# Uses Nautilus and Python3 wrapper

# main packages installation
sudo apt update
sudo apt -y install python3-nautilus
sudo apt -y install libfile-mimeinfo-perl libjpeg-turbo-progs netpbm

# remove files from previous version
sudo rm --force /usr/share/file-manager/actions/image-rotate.desktop
sudo rm --force /usr/share/file-manager/actions/image-rotate-*.desktop
rm --force $HOME/.local/share/file-manager/actions/image-rotate-*.desktop

# show icon in menus (command different according to gnome version)
gsettings set org.gnome.desktop.interface menus-have-icons true
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/ButtonImages': <1>, 'Gtk/MenuImages': <1>}"

# install icons
sudo wget -O /usr/share/icons/image-rotate.png https://raw.githubusercontent.com/NicolasBernaerts/icon/refs/heads/master/image/image-rotate.png
sudo wget -O /usr/share/icons/rotate-left.png https://raw.githubusercontent.com/NicolasBernaerts/icon/refs/heads/master/rotation/rotate-left.png
sudo wget -O /usr/share/icons/rotate-right.png https://raw.githubusercontent.com/NicolasBernaerts/icon/refs/heads/master/rotation/rotate-right.png
sudo wget -O /usr/share/icons/rotate-updown.png https://raw.githubusercontent.com/NicolasBernaerts/icon/refs/heads/master/rotation/rotate-updown.png

# main script installation
sudo wget -O /usr/local/bin/image-rotate https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/image/image-rotate
sudo chmod +x /usr/local/bin/image-rotate

# desktop integration
mkdir --parents $HOME/.local/share/nautilus-python/extensions
wget -O $HOME/.local/share/nautilus-python/extensions/image-rotate-menu.py https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/image/image-rotate-menu.py
