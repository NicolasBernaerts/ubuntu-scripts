#!/bin/sh
# Ms Office thumbnailer

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install libfile-mimeinfo-perl gvfs-bin unoconv netpbm

# install thumbnailer icons
sudo mkdir /usr/local/sbin/msoffice-thumbnailer.res
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/msoffice-thumbnailer.res/msoffice-odt.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/msoffice/icons/msoffice-odt.png
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/msoffice-thumbnailer.res/msoffice-ods.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/msoffice/icons/msoffice-ods.png
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/msoffice-thumbnailer.res/msoffice-odp.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/msoffice/icons/msoffice-odp.png

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/msoffice-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/msoffice/msoffice-thumbnailer
sudo chmod +rx /usr/local/sbin/msoffice-thumbnailer

# thumbnailer integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/thumbnailers/msoffice.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/msoffice/msoffice.thumbnailer

# if present, disable gsf-office.thumbnailer (used in UbuntuGnome 16.04)
[ -f /usr/share/thumbnailers/gsf-office.thumbnailer ] && sudo mv /usr/share/thumbnailers/gsf-office.thumbnailer /usr/share/thumbnailers/gsf-office.thumbnailer.org

# stop nautilus
nautilus -q

# remove previous thumbnails and cache
rm -R $HOME/.cache/thumbnails/*
rm -R $HOME/.cache/msoffice-thumbnailer
