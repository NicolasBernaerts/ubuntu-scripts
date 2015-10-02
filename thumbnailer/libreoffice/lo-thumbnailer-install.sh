#!/bin/sh
# LibreOffice thumbnailer

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install libfile-mimeinfo-perl gvfs-bin unzip imagemagick

# install thumbnailer helper files
wget --header='Accept-Encoding:none' http://bernaerts.dyndns.org/download/gnome/thumbnailer/lo-thumbnailer-icons.zip
sudo unzip -d /usr/local/sbin lo-thumbnailer-icons.zip
rm lo-thumbnailer-icons.zip

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/lo-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/libreoffice/lo-thumbnailer
sudo chmod +rx /usr/local/sbin/lo-thumbnailer

# thumbnailer integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/thumbnailers/lo.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/libreoffice/lo.thumbnailer
