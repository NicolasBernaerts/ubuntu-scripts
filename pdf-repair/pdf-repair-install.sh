#!/bin/sh
# PDF repair extension

sudo apt-get -y install gvfs-bin libnotify-bin ghostscript zenity
sudo wget -O /usr/local/bin/pdf-repair https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf-repair/pdf-repair
sudo chmod +x /usr/local/bin/pdf-repair
sudo wget -O /usr/share/applications/pdf-repair.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf-repair/pdf-repair.desktop
mkdir --parents $HOME/.local/share/file-manager/actions
wget -O $HOME/.local/share/file-manager/actions/pdf-repair-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf-repair/pdf-repair-action.desktop
