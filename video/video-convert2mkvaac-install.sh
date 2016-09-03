#!/bin/bash
# Convert any video file to MKV with AAC audio and add midnight mode tracks

# test Ubuntu or Linux Minty distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "LinuxMint" ] && [ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu or Linux Mint"; exit 1; }

# install yad
sudo apt-get -y install yad

# install fdkaac encoder
sudo apt-get -y install fdkaac aac-enc

# install mediainfo, libav-tools (avconv), sox and mkvtoolnix (mkvmerge)
sudo apt-get -y install mediainfo libav-tools sox mkvtoolnix

# if nautilus present, install nautilus-actions
command -v nautilus >/dev/null 2>&1 && sudo apt-get -y install nautilus-actions

# install configuration file
mkdir --parents $HOME/.config
wget --header='Accept-Encoding:none' -O $HOME/.config/video-convert2mkvaac.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-convert2mkvaac.conf

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/video-convert2mkvaac https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-convert2mkvaac
sudo chmod +x /usr/local/bin/video-convert2mkvaac

# declare desktop integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/applications/video-convert2mkvaac.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-convert2mkvaac.desktop
mkdir --parents $HOME/.local/share/file-manager/actions
wget --header='Accept-Encoding:none' -O $HOME/.local/share/file-manager/actions/video-convert2mkvaac-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-convert2mkvaac-action.desktop
