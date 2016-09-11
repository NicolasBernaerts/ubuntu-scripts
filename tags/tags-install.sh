#!/bin/sh
# image tags extensions

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install libimage-exiftool-perl imagemagick

# install yad
sudo apt-get -y install yad

# install configuration file
mkdir --parents $HOME/.config
wget --header='Accept-Encoding:none' -O $HOME/.config/tags-update.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-update.conf

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/tags-update https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-update
sudo chmod +x /usr/local/bin/tags-update
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/tags-date https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-date
sudo chmod +x /usr/local/bin/tags-date

# desktop integration : icon
sudo wget --header='Accept-Encoding:none' -O /usr/share/icons/tags.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags.png

# close all nautilus instances
nautilus -q

# desktop integration : preparation
mkdir --parents $HOME/.local/share/file-manager/actions
rm $HOME/.local/share/file-manager/actions/tags-*.desktop

# desktop integration : root menu
wget -O $HOME/.local/share/file-manager/actions/tags-menu.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-menu.desktop

# start nautilus and wait for 5 seconds for the menu to be declared
nautilus &
sleep 5

# desktop integration : entries
wget -O $HOME/.local/share/file-manager/actions/tags-update-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-update-action.desktop
wget -O $HOME/.local/share/file-manager/actions/tags-date-shift.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-date-shift.desktop
wget -O $HOME/.local/share/file-manager/actions/tags-date-rename.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-date-rename.desktop
wget -O $HOME/.local/share/file-manager/actions/tags-date-system.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-date-system.desktop

# close all nautilus instances
nautilus -q
