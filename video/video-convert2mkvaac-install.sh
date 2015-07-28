#!/bin/bash
# Convert any video file to MKV with AAC audio and add midnight mode tracks

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install yad
IS_PRESENT=$(command -v yad)
if [ -z "${IS_PRESENT}" ]
then
  sudo add-apt-repository -y ppa:webupd8team/y-ppa-manager
  sudo apt-get update
  sudo apt-get -y install yad
fi

# install fdkaac encoder
IS_PRESENT=$(command -v fdkaac)
if [ -z "${IS_PRESENT}" ]
then
  sudo add-apt-repository -y ppa:mc3man/fdkaac-encoder
  sudo apt-get update
  sudo apt-get -y install fdkaac-encoder aac-enc
fi

# install mediainfo, libav-tools (avconv), sox and mkvtoolnix (mkvmerge)
sudo apt-get -y install mediainfo libav-tools sox mkvtoolnix

# if nautilus present, install nautilus-actions
command -v nautilus >/dev/null 2>&1 && sudo apt-get -y install nautilus-actions

# install configuration file
mkdir --parents $HOME/.config
wget -O $HOME/.config/video-convert2mkvaac.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-convert2mkvaac.conf

# install main script
sudo wget -O /usr/local/bin/video-convert2mkvaac https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-convert2mkvaac
sudo chmod +x /usr/local/bin/video-convert2mkvaac

# declare desktop integration
sudo wget -O /usr/share/applications/video-convert2mkvaac.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-convert2mkvaac.desktop
mkdir --parents $HOME/.local/share/file-manager/actions
wget -O $HOME/.local/share/file-manager/actions/video-convert2mkvaac-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-convert2mkvaac-action.desktop
