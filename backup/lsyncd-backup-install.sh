#!/bin/sh
# Realtime personal data backup thru lsyncd

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install lsyncd

# install main scripts
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/lsyncd-backup https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/backup/lsyncd-backup
sudo chmod +x /usr/local/bin/lsyncd-backup

# desktop integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/applications/lsyncd-backup.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/backup/lsyncd-backup.desktop
