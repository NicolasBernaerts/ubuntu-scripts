#!/bin/sh
# LibreOffice thumbnailer

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install libfile-mimeinfo-perl gvfs-bin unzip imagemagick

# install thumbnailer icons
sudo mkdir /usr/local/sbin/lo-thumbnailer-icons
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/lo-thumbnailer-icons/lo-mask.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/libreoffice/icons/lo-mask.png
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/lo-thumbnailer-icons/lo-database.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/libreoffice/icons/lo-database.png
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/lo-thumbnailer-icons/lo-graphics.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/libreoffice/icons/lo-graphics.png
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/lo-thumbnailer-icons/lo-presentation.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/libreoffice/icons/lo-presentation.png
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/lo-thumbnailer-icons/lo-spreadsheet.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/libreoffice/icons/lo-spreadsheet.png
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/lo-thumbnailer-icons/lo-text.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/libreoffice/icons/lo-text.png

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/lo-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/libreoffice/lo-thumbnailer
sudo chmod +rx /usr/local/sbin/lo-thumbnailer

# thumbnailer integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/thumbnailers/lo.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/libreoffice/lo.thumbnailer

# if present, disable gsf-office.thumbnailer (used in UbuntuGnome 16.04)
[ -f /usr/share/thumbnailers/gsf-office.thumbnailer ] && sudo mv /usr/share/thumbnailers/gsf-office.thumbnailer /usr/share/thumbnailers/gsf-office.thumbnailer.org
