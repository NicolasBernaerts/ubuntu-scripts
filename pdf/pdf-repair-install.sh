#!/bin/sh
# PDF repair extension

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install gvfs-bin libnotify-bin ghostscript mupdf-tools gridsite-clients

# if nautilus present, install nautilus-actions
command -v nautilus >/dev/null 2>&1 && sudo apt-get -y install nautilus-actions

# enable icon in nautilus menus
gsettings set org.gnome.desktop.interface menus-have-icons true

# install icons
sudo wget --header='Accept-Encoding:none' -O /usr/share/icons/pdf-repair.png https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/pdf/icons/pdf-repair.png

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/pdf-repair https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-repair
sudo chmod +x /usr/local/bin/pdf-repair

# desktop integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/applications/pdf-repair.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-repair.desktop
mkdir --parents $HOME/.local/share/file-manager/actions
wget --header='Accept-Encoding:none' -O $HOME/.local/share/file-manager/actions/pdf-repair-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-repair-action.desktop
