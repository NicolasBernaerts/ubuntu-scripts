#!/bin/sh
# image tags extensions

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install libimage-exiftool-perl imagemagick

# install yad
IS_PRESENT=$(command -v yad)
if [ -z "${IS_PRESENT}" ]
then
  sudo add-apt-repository -y ppa:webupd8team/y-ppa-manager
  sudo apt-get update
  sudo apt-get -y install yad
fi

# install configuration file
mkdir --parents $HOME/.config
wget --header='Accept-Encoding:none' -O $HOME/.config/tags-xmp.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-xmp.conf

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/tags-common https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-common
sudo chmod +x /usr/local/bin/tags-common
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/tags-xmp https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-xmp
sudo chmod +x /usr/local/bin/tags-xmp
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/tags-timeshift https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-timeshift
sudo chmod +x /usr/local/bin/tags-timeshift
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/tags-creationdate https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-creationdate
sudo chmod +x /usr/local/bin/tags-creationdate

# desktop integration : icon
sudo wget --header='Accept-Encoding:none' -O /usr/share/icons/tags.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags.png

# desktop integration : preparation
mkdir --parents $HOME/.local/share/file-manager/actions
rm $HOME/.local/share/file-manager/actions/tags-*.desktop

# desktop integration : root menu
wget -O $HOME/.local/share/file-manager/actions/tags-menu.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-menu.desktop

# desktop integration : entries
wget -O $HOME/.local/share/file-manager/actions/tags-xmp-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-xmp-action.desktop
wget -O $HOME/.local/share/file-manager/actions/tags-timeshift-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-timeshift-action.desktop
wget -O $HOME/.local/share/file-manager/actions/tags-creationdate-rename.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-creationdate-rename.desktop
wget -O $HOME/.local/share/file-manager/actions/tags-creationdate-system.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-creationdate-system.desktop
