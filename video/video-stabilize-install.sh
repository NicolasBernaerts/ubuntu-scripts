#!/usr/bin/env bash
# Video rotation and stabilization
# This version is meant for Xenial 16.04, it is not compatible anymore with 14.04

# test Ubuntu or Linux Minty distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "LinuxMint" ] && [ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu or Linux Mint"; exit 1; }

# install melt from official repository (without vid.stab filter)
sudo apt-get update
sudo apt-get -y install melt

# install yad, x264 and exiftool
sudo apt-get -y install yad x264 libimage-exiftool-perl

# if nautilus present, install nautilus-actions
command -v nautilus >/dev/null 2>&1 && sudo apt-get -y install nautilus-actions

# If not present, install specific version of melt with vid.stab filter
if [ ! -f /opt/vidstab/melt ]
then
  wget --header='Accept-Encoding:none' https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/melt-vidstab-install.sh
  . ./melt-vidstab-install.sh
fi

# install configuration file
mkdir --parents $HOME/.config
wget --header='Accept-Encoding:none' -O $HOME/.config/video-stabilize.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-stabilize.conf

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/video-stabilize https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-stabilize
sudo chmod +x /usr/local/bin/video-stabilize

# desktop integration : icon
sudo wget --header='Accept-Encoding:none' -O /usr/share/icons/stabilizer.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/stabilizer.png

# desktop integration : application
sudo wget --header='Accept-Encoding:none' -O /usr/share/applications/video-stabilize.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-stabilize.desktop

# desktop integration : nautilus action
mkdir --parents $HOME/.local/share/file-manager/actions
wget --header='Accept-Encoding:none' -O $HOME/.local/share/file-manager/actions/video-stabilize-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-stabilize-action.desktop
