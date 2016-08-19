#!/bin/sh
# Ms Office thumbnailer

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install libfile-mimeinfo-perl gvfs-bin unoconv imagemagick

# install thumbnailer icons
sudo mkdir /usr/local/sbin/msoffice-thumbnailer-icons
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/msoffice-thumbnailer-icons/msoffice-mask.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/msoffice/icons/msoffice-mask.png
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/msoffice-thumbnailer-icons/msoffice-word.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/msoffice/icons/msoffice-word.png
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/msoffice-thumbnailer-icons/msoffice-excel.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/msoffice/icons/msoffice-excel.png
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/msoffice-thumbnailer-icons/msoffice-powerpoint.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/msoffice/icons/msoffice-powerpoint.png

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/msoffice-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/msoffice/msoffice-thumbnailer
sudo chmod +rx /usr/local/sbin/msoffice-thumbnailer

# thumbnailer integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/thumbnailers/msoffice.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/msoffice/msoffice.thumbnailer

# if present, disable gsf-office.thumbnailer (used in UbuntuGnome 16.04)
[ -f /usr/share/thumbnailers/gsf-office.thumbnailer ] && sudo mv /usr/share/thumbnailers/gsf-office.thumbnailer /usr/share/thumbnailers/gsf-office.thumbnailer.org
