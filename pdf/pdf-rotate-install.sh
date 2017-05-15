#!/bin/sh
# PDF rotation nautilus extension

# if nautilus present, install nautilus-actions
command -v nautilus >/dev/null 2>&1 && sudo apt-get -y install nautilus-actions

# main packages installation
sudo apt-get -y install texlive-extra-utils

# show icon in menus (command different according to gnome version)
gsettings set org.gnome.desktop.interface menus-have-icons true
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/ButtonImages': <1>, 'Gtk/MenuImages': <1>}"

# install icons
sudo wget --header='Accept-Encoding:none' -O /usr/share/icons/pdf-menu.png https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/pdf/icons/pdf-menu.png
sudo wget --header='Accept-Encoding:none' -O /usr/share/icons/rotate-left.png https://github.com/NicolasBernaerts/icon/raw/master/rotate-left.png
sudo wget --header='Accept-Encoding:none' -O /usr/share/icons/rotate-right.png https://github.com/NicolasBernaerts/icon/raw/master/rotate-right.png
sudo wget --header='Accept-Encoding:none' -O /usr/share/icons/revert-updown.png https://github.com/NicolasBernaerts/icon/raw/master/revert-updown.png

# main script installation
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/pdf-rotate https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-rotate
sudo chmod +x /usr/local/bin/pdf-rotate

# nautilus action integration
sudo mkdir --parents /usr/share/file-manager/actions
sudo wget --header='Accept-Encoding:none' -O /usr/share/file-manager/actions/pdf-rotate-menu.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-rotate-menu.desktop
sudo wget --header='Accept-Encoding:none' -O /usr/share/file-manager/actions/pdf-rotate-left-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-rotate-left-action.desktop
sudo wget --header='Accept-Encoding:none' -O /usr/share/file-manager/actions/pdf-rotate-right-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-rotate-right-action.desktop
sudo wget --header='Accept-Encoding:none' -O /usr/share/file-manager/actions/pdf-rotate-updown-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-rotate-updown-action.desktop
