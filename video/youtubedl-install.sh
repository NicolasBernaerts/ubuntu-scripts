#!/usr/bin/env bash
# Youtube Downloader GUI

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }


# install youtube-dl and mkvmerge
sudo apt-get update
sudo apt-get -y install youtube-dl mkvmerge

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/youtubedl-gui https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/youtubedl-gui
sudo chmod +x /usr/local/bin/youtubedl-gui
