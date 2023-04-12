#!/bin/sh
# Home data backup thru rsync

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install rsync

# install main scripts
sudo wget -O /usr/local/bin/rsync-home https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/backup/rsync-home
sudo wget -O /usr/local/bin/rsync.awk https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/backup/rsync.awk
sudo chmod +x /usr/local/bin/rsync-home

# desktop integration
sudo wget -O /usr/share/applications/rsync-home.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/backup/rsync-home.desktop
