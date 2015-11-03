#!/bin/sh
# PDF booklet generation extension

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install poppler-utils texlive-extra-utils mimetype unoconv

# if nautilus present, install nautilus-actions
command -v nautilus >/dev/null 2>&1 && sudo apt-get -y install nautilus-actions

# show icon in menus
gsettings set org.gnome.desktop.interface menus-have-icons true

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/generate-booklet https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/generate-booklet
sudo chmod +x /usr/local/bin/generate-booklet

# desktop integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/applications/generate-booklet.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/generate-booklet.desktop
mkdir --parents $HOME/.local/share/file-manager/actions
wget --header='Accept-Encoding:none' -O $HOME/.local/share/file-manager/actions/generate-booklet-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/generate-booklet-action.desktop
