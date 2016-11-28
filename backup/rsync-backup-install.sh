#!/bin/sh
# Personal data backup thru rsync

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install rsync

# install configuration file
wget --header='Accept-Encoding:none' -O $HOME/.rsync-backup.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/backup/rsync-backup.conf

# install main scripts
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/rsync-backup https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/backup/rsync-backup
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/rsync-backup.awk https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/backup/rsync-backup.awk
sudo chmod +x /usr/local/bin/rsync-backup

# desktop integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/applications/rsync-backup.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/backup/rsync-backup.desktop
