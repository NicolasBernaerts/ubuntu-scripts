#!/bin/sh
# Install PDF booklet generation extension
# Uses Nautilus and Python3 wrapper

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install python3-nautilus
sudo apt-get -y install poppler-utils texlive-extra-utils unoconv

# remove files from previous version
[ -f "/usr/share/applications/generate-booklet.desktop" ] && sudo rm "/usr/share/applications/generate-booklet.desktop"
[ -f "/usr/share/applications/pdf-booklet.desktop" ] && sudo rm "/usr/share/applications/pdf-booklet.desktop"
[ -f "$HOME/.local/share/file-manager/actions/generate-booklet-action.desktop" ] && rm "$HOME/.local/share/file-manager/actions/generate-booklet-action.desktop"

# show icon in menus (command different according to gnome version)
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/ButtonImages': <1>, 'Gtk/MenuImages': <1>}"

# install icon
sudo wget -O /usr/share/icons/pdf-booklet.png https://raw.githubusercontent.com/NicolasBernaerts/icon/refs/heads/master/pdf/pdf-booklet.png

# install main script
sudo wget -O /usr/local/bin/pdf-booklet https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/pdf/pdf-booklet
sudo chmod +x /usr/local/bin/pdf-booklet

# desktop integration
mkdir --parents $HOME/.local/share/nautilus-python/extensions
wget -O $HOME/.local/share/nautilus-python/extensions/pdf-booklet-menu.py https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/pdf/pdf-booklet-menu.py
