#!/bin/sh
# Image rotation nautilus extension

# if nautilus present, install nautilus-actions
command -v nautilus >/dev/null 2>&1 && sudo apt-get -y install nautilus-actions

# main packages installation
sudo apt-get -y install libfile-mimeinfo-perl libjpeg-turbo-progs netpbm

# show icon in menus (command different according to gnome version)
gsettings set org.gnome.desktop.interface menus-have-icons true
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/ButtonImages': <1>, 'Gtk/MenuImages': <1>}"

# install icons
sudo wget --header='Accept-Encoding:none' -O /usr/share/icons/image-rotate.png https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/image/image-rotate.png
sudo wget --header='Accept-Encoding:none' -O /usr/share/icons/rotate-left.png https://github.com/NicolasBernaerts/icon/raw/master/rotate-left.png
sudo wget --header='Accept-Encoding:none' -O /usr/share/icons/rotate-right.png https://github.com/NicolasBernaerts/icon/raw/master/rotate-right.png
sudo wget --header='Accept-Encoding:none' -O /usr/share/icons/revert-updown.png https://github.com/NicolasBernaerts/icon/raw/master/revert-updown.png

# main script installation
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/image-rotate https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-rotate
sudo chmod +x /usr/local/bin/image-rotate

# nautilus action integration
sudo mkdir --parents /usr/share/file-manager/actions
sudo wget --header='Accept-Encoding:none' -O /usr/share/file-manager/actions/image-rotate-menu.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-rotate-menu.desktop
sudo wget --header='Accept-Encoding:none' -O /usr/share/file-manager/actions/image-rotate-left-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-rotate-left-action.desktop
sudo wget --header='Accept-Encoding:none' -O /usr/share/file-manager/actions/image-rotate-right-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-rotate-right-action.desktop
sudo wget --header='Accept-Encoding:none' -O /usr/share/file-manager/actions/image-rotate-updown-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-rotate-updown-action.desktop
