#!/usr/bin/env bash
# Video rotation and stabilization

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# declare sunab/kdenlive-release ppa if not declared
PPA_NAME="sunab/kdenlive-release"
IS_PRESENT=$(grep "^[^#].*${PPA_NAME}.*" /etc/apt/sources.list /etc/apt/sources.list.d/*)
if [ -z "${IS_PRESENT}" ]
then
  sudo add-apt-repository -y ppa:sunab/kdenlive-release
fi

# install melt and libvidstab
sudo apt-get update
sudo apt-get -y install libvidstab1.0 melt

# install yad
IS_PRESENT=$(command -v yad)
if [ -z "${IS_PRESENT}" ]
then
  sudo add-apt-repository -y ppa:webupd8team/y-ppa-manager
  sudo apt-get update
  sudo apt-get -y install yad
fi

# install x264 and exiftool
sudo apt-get -y install x264 libimage-exiftool-perl

# install opencv-data, to avoid error
#   Could not load classifier cascade /usr/share/opencv/haarcascades/haarcascade_frontalface_alt2.xml
sudo apt-get -y install opencv-data

# if nautilus present, install nautilus-actions
command -v nautilus >/dev/null 2>&1 && sudo apt-get -y install nautilus-actions

# install configuration file
mkdir --parents $HOME/.config
wget --header='Accept-Encoding:none' -O $HOME/.config/video-stabilize.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-stabilize.conf

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/video-stabilize https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-stabilize
sudo chmod +x /usr/local/bin/video-stabilize

# desktop integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/icons/stabilizer.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/stabilizer.png
sudo wget --header='Accept-Encoding:none' -O /usr/share/applications/video-stabilize.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-stabilize.desktop
mkdir --parents $HOME/.local/share/file-manager/actions
wget --header='Accept-Encoding:none' -O $HOME/.local/share/file-manager/actions/video-stabilize-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-stabilize-action.desktop
