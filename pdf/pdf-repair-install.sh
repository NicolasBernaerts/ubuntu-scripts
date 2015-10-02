#!/bin/sh
# PDF repair extension

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install gvfs-bin libnotify-bin ghostscript zenity

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/pdf-repair https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-repair
sudo chmod +x /usr/local/bin/pdf-repair

# desktop integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/applications/pdf-repair.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-repair.desktop
mkdir --parents $HOME/.local/share/file-manager/actions
wget --header='Accept-Encoding:none' -O $HOME/.local/share/file-manager/actions/pdf-repair-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-repair-action.desktop
