#!/bin/bash
# PDF compress extension

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# main packages installation
sudo apt -y install imagemagick
sudo apt -y install texlive-extra-utils
sudo apt -y install ghostscript mupdf-tools

# remove imagemagick PDF generation restrictions
wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/imagemagisk-enable-pdf-install.sh
if [ -f ./imagemagisk-enable-pdf-install.sh ]
then
  logger "graphical - ImageMagick PDF and PostScript restriction removal"
  chmod +x ./imagemagisk-enable-pdf-install.sh
  ./imagemagisk-enable-pdf-install.sh
  rm ./imagemagisk-enable-pdf-install.sh
fi

# if nautilus present, install nautilus-actions
command -v nautilus >/dev/null 2>&1 && sudo apt-get -y install nautilus-actions

# show icon in menus (command different according to gnome version)
gsettings set org.gnome.desktop.interface menus-have-icons true
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/ButtonImages': <1>, 'Gtk/MenuImages': <1>}"

# install main menu icon
sudo wget -O /usr/share/icons/pdf-menu.png https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/pdf/icons/pdf-menu.png

# if needed, create nautilus python extensions folder
mkdir --parents $HOME/.local/share/nautilus-python/extensions
wget -O $HOME/.local/share/nautilus-python/extensions/pdf-tools-menu.py https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-tools-menu.py

# -----------------
#  PDF compression
# -----------------

# install icon
sudo wget -O /usr/share/icons/pdf-compress.png https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/pdf/icons/pdf-compress.png

# install main script
sudo wget -O /usr/local/bin/pdf-compress https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-compress
sudo chmod +x /usr/local/bin/pdf-compress

# -----------------
#  PDF repair
# -----------------

# install icon
sudo wget -O /usr/share/icons/pdf-repair.png https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/pdf/icons/pdf-repair.png

# install main script
sudo wget -O /usr/local/bin/pdf-repair https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-repair
sudo chmod +x /usr/local/bin/pdf-repair

# -----------------
#  PDF rotate
# -----------------

# install icons
sudo wget -O /usr/share/icons/rotate-left.png https://github.com/NicolasBernaerts/icon/raw/master/rotate-left.png
sudo wget -O /usr/share/icons/rotate-right.png https://github.com/NicolasBernaerts/icon/raw/master/rotate-right.png
sudo wget -O /usr/share/icons/rotate-updown.png https://github.com/NicolasBernaerts/icon/raw/master/revert-updown.png

# install main script
sudo wget -O /usr/local/bin/pdf-rotate https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-rotate
sudo chmod +x /usr/local/bin/pdf-rotate
