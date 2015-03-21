#!/bin/sh
# Personal data backup thru rsync

sudo apt-get -y install rsync
wget -O $HOME/.rsync-backup.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/rsync/rsync-backup.conf
sudo wget -O /usr/local/bin/rsync-backup https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/rsync/rsync-backup
sudo wget -O /usr/local/bin/rsync-backup.awk https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/rsync/rsync-backup.awk
sudo chmod +x /usr/local/bin/rsync-backup
sudo wget -O /usr/share/applications/rsync-backup.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/rsync/rsync-backup.desktop
