#!/bin/sh
# Install PDF rotation nautilus extension

# main packages installation
sudo apt -y install texlive-extra-utils

# show icon in menus (command different according to gnome version)
gsettings set org.gnome.desktop.interface menus-have-icons true
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/ButtonImages': <1>, 'Gtk/MenuImages': <1>}"

# main script installation
sudo wget -O /usr/local/bin/pdf-rotate https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-rotate
sudo chmod +x /usr/local/bin/pdf-rotate

# action icons
wget -O $HOME/.local/share/icons/pdf-menu.png https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/pdf/icons/pdf-menu.png
wget -O $HOME/.local/share/icons/rotate-left.png https://github.com/NicolasBernaerts/icon/raw/master/rotate-left.png
wget -O $HOME/.local/share/icons/rotate-right.png https://github.com/NicolasBernaerts/icon/raw/master/rotate-right.png
wget -O $HOME/.local/share/icons/revert-updown.png https://github.com/NicolasBernaerts/icon/raw/master/revert-updown.png

# nautilus action integration
mkdir --parents $HOME/.local/share/file-manager/actions
wget -O $HOME/.local/share/file-manager/actions/pdf-rotate-menu.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-rotate-menu.desktop
wget -O $HOME/.local/share/file-manager/actions/pdf-rotate-left-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-rotate-left-action.desktop
wget -O $HOME/.local/share/file-manager/actions/pdf-rotate-right-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-rotate-right-action.desktop
wget -O $HOME/.local/share/file-manager/actions/pdf-rotate-updown-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-rotate-updown-action.desktop
