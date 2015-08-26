#!/bin/sh
# XMP tags editor extension

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install exiftool imagemagick zenity

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
wget -O $HOME/.config/xmp-tagger.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/xmp-tagger.conf

# install main script
sudo wget -O /usr/local/bin/xmp-tagger https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/xmp-tagger
sudo chmod +x /usr/local/bin/xmp-tagger

# desktop integration
sudo wget -O /usr/share/applications/xmp-tagger.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/xmp-tagger.desktop
mkdir --parents $HOME/.local/share/file-manager/actions
wget -O $HOME/.local/share/file-manager/actions/xmp-tagger-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/xmp-tagger-action.desktop
