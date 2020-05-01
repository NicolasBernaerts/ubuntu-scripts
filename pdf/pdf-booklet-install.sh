#!/bin/sh
# Install PDF booklet generation extension

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install poppler-utils texlive-extra-utils mimetype unoconv

# if nautilus present, install nautilus-actions
#command -v nautilus >/dev/null 2>&1 && sudo apt-get -y install nautilus-actions

# show icon in menus (command different according to gnome version)
gsettings set org.gnome.desktop.interface menus-have-icons true
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/ButtonImages': <1>, 'Gtk/MenuImages': <1>}"

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/pdf-booklet https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-booklet
sudo chmod +x /usr/local/bin/pdf-booklet

# desktop integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/applications/pdf-booklet.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-booklet.desktop
mkdir --parents $HOME/.local/share/file-manager/actions
wget --header='Accept-Encoding:none' -O $HOME/.local/share/file-manager/actions/pdf-booklet-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-booklet-action.desktop
