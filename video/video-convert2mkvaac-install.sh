#!/usr/bin/env bash
# Convert any video file to MKV with AAC audio and add midnight mode tracks

# test Ubuntu or Linux Minty distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "LinuxMint" ] && [ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu or Linux Mint"; exit 1; }

# install tools
sudo apt -y install yad
sudo apt -y install fdkaac aac-enc
sudo apt -y install mediainfo ffmpeg sox mkvtoolnix

# remove files from previous version
sudo rm --force /usr/share/applications/video-convert2mkvaac.desktop
rm --force $HOME/.local/share/file-manager/actions/video-convert2mkvaac-action.desktop

# install icons
sudo wget -O /usr/share/icons/video-aac.png https://github.com/NicolasBernaerts/icon/raw/refs/heads/master/video/video-aac.png

# install configuration file
mkdir --parents $HOME/.config
wget -O $HOME/.config/video-convert2mkvaac.conf https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/video/video-convert2mkvaac.conf

# install main script
sudo wget -O /usr/local/bin/video-convert2mkvaac https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/video/video-convert2mkvaac
sudo chmod +x /usr/local/bin/video-convert2mkvaac

# declare nautilus menu
mkdir --parents $HOME/.local/share/nautilus-python/extensions
wget -O $HOME/.local/share/nautilus-python/extensions/video-convert2mkvaac-menu.py https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/video/video-convert2mkvaac-menu.py
