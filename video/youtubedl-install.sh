#!/usr/bin/env bash
# Youtube Downloader GUI

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

# install youtube-dl and mkvmerge
sudo apt-get update
sudo apt-get -y install youtube-dl mkvtoolnix

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/youtubedl-gui https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/youtubedl-gui
sudo chmod +x /usr/local/bin/youtubedl-gui
