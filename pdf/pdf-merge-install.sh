#!/bin/sh
# Install PDF merge extension
# Uses Nautilus and Python3 wrapper

# main packages installation
sudo apt -y install python3-nautilus
sudo apt -y install imagemagick unoconv ghostscript

# remove files from previous version
sudo rm --force /usr/local/bin/pdf-generate
sudo rm --force /usr/share/applications/pdf-generate.desktop
sudo rm --force /usr/share/applications/pdf-generate-action.desktop
rm --force $HOME/.local/share/file-manager/actions/pdf-generate.desktop
rm --force $HOME/.local/share/file-manager/actions/pdf-generate-action.desktop

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

# install icons
sudo wget -O /usr/share/icons/pdf-generate.png https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/icon/pdf/pdf-merge.png

# main script installation
sudo wget -O /usr/local/bin/pdf-merge https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-merge
sudo chmod +x /usr/local/bin/pdf-merge

# desktop integration
mkdir --parents $HOME/.local/share/nautilus-python/extensions
wget -O $HOME/.local/share/nautilus-python/extensions/pdf-merge-menu.py https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-merge-menu.py

