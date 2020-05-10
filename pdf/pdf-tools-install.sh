#!/bin/bash
# Misc PDF tools extension (compress & repair)
# Uses Nautilus and Python3 wrapper

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# main packages installation
sudo apt -y install python3-nautilus
sudo apt -y install imagemagick texlive-extra-utils
sudo apt -y install ghostscript mupdf-tools

# remove files from previous version
[ -f /usr/share/applications/pdf-repair.desktop ] && sudo rm /usr/share/applications/pdf-repair.desktop
[ -f $HOME/.local/share/file-manager/actions/pdf-compress-action.desktop ] && rm $HOME/.local/share/file-manager/actions/pdf-compress-action.desktop
[ -f $HOME/.local/share/file-manager/actions/pdf-repair-action.desktop ] && rm $HOME/.local/share/file-manager/actions/pdf-repair-action.desktop


# if needed, remove imagemagick PDF generation restrictions
if [ ! -f "/etc/apt/apt.conf.d/99imagemagick-enable-pdf" ]
then
	wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/imagemagisk-enable-pdf-install.sh
	if [ -f ./imagemagisk-enable-pdf-install.sh ]
	then
		logger "graphical - ImageMagick PDF and PostScript restriction removal"
		chmod +x ./imagemagisk-enable-pdf-install.sh
		./imagemagisk-enable-pdf-install.sh
		rm ./imagemagisk-enable-pdf-install.sh
	fi
fi

# show icon in menus (command different according to gnome version)
gsettings set org.gnome.desktop.interface menus-have-icons true
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/ButtonImages': <1>, 'Gtk/MenuImages': <1>}"

# install main menu icon
sudo wget -O /usr/share/icons/pdf-menu.png https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/icon/pdf/pdf-menu.png

# desktop integration
mkdir --parents $HOME/.local/share/nautilus-python/extensions
wget -O $HOME/.local/share/nautilus-python/extensions/pdf-tools-menu.py https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-tools-menu.py

# -----------------
#  PDF compression
# -----------------

# install icon
sudo wget -O /usr/share/icons/pdf-compress.png https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/icon/pdf/pdf-compress.png

# install main script
sudo wget -O /usr/local/bin/pdf-compress https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-compress
sudo chmod +x /usr/local/bin/pdf-compress

# -----------------
#  PDF repair
# -----------------

# install icon
sudo wget -O /usr/share/icons/pdf-repair.png https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/icon/pdf/pdf-repair.png

# install main script
sudo wget -O /usr/local/bin/pdf-repair https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-repair
sudo chmod +x /usr/local/bin/pdf-repair
