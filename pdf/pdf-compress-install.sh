#!/bin/sh
# PDF compress extension

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install imagemagick

# if nautilus present, install nautilus-actions
command -v nautilus >/dev/null 2>&1 && sudo apt-get -y install nautilus-actions

# show icon in menus (command different according to gnome version)
gsettings set org.gnome.desktop.interface menus-have-icons true
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/ButtonImages': <1>, 'Gtk/MenuImages': <1>}"

# install icons
sudo wget -O /usr/share/icons/pdf-compress.png https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/pdf/icons/pdf-compress.png

# install main script
sudo wget -O /usr/local/bin/pdf-compress https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-compress
sudo chmod +x /usr/local/bin/pdf-compress

# desktop integration
mkdir --parents $HOME/.local/share/file-manager/actions
wget -O $HOME/.local/share/file-manager/actions/pdf-compress-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-compress-action.desktop
