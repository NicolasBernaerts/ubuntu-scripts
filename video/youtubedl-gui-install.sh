#!/usr/bin/env bash
# Youtube Downloader GUI

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install youtube-dl, mkvmerge and yad
sudo apt-get update
sudo apt-get -y install youtube-dl mkvtoolnix yad

# install configuration file and configure default directory
wget --header='Accept-Encoding:none' -O $HOME/.config/youtubedl-gui.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/youtubedl-gui.conf
sed -i "s|^directory=.*$|directory="$HOME"/Videos|" $HOME/.config/youtubedl-gui.conf

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/youtubedl-gui https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/youtubedl-gui
sudo chmod +x /usr/local/bin/youtubedl-gui
