#!/bin/bash
# Video rotation and stabilization

# install melt and vidstab
IS_PRESENT=$(command -v melt)
if [ -z "${IS_PRESENT}" ]
then
  sudo add-apt-repository -y ppa:sunab/kdenlive-release
  sudo apt-get update
  sudo apt-get -y install libvidstab1.0 melt
fi

# install yad
IS_PRESENT=$(command -v yad)
if [ -z "${IS_PRESENT}" ]
then
  sudo add-apt-repository -y ppa:webupd8team/y-ppa-manager
  sudo apt-get update
  sudo apt-get -y install yad
fi

# install x264
sudo apt-get -y install x264

# install exiftool
sudo apt-get -y install libimage-exiftool-perl

# if nautilus present, install nautilus-actions
command -v nautilus >/dev/null 2>&1 && sudo apt-get -y install nautilus-actions

# install script and configuration
mkdir --parents $HOME/.config
wget -O $HOME/.config/video-stabilize.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-stabilize.conf
sudo wget -O /usr/local/bin/video-stabilize https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-stabilize
sudo chmod +x /usr/local/bin/video-stabilize
sudo wget -O /usr/share/icons/stabilizer.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/stabilizer.png

# desktop integration
sudo wget -O /usr/share/applications/video-stabilize.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-stabilize.desktop
mkdir --parents $HOME/.local/share/file-manager/actions
wget -O $HOME/.local/share/file-manager/actions/video-stabilize-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-stabilize-action.desktop
