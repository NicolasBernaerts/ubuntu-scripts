#!/bin/sh
# XMP tags editor extension

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install libimage-exiftool-perl imagemagick zenity

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
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/tags-xmp https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-xmp
sudo chmod +x /usr/local/bin/tags-xmp

# desktop integration
mkdir --parents $HOME/.local/share/file-manager/actions
wget -O $HOME/.local/share/file-manager/actions/tags-xmp-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tags/tags-xmp-action.desktop
