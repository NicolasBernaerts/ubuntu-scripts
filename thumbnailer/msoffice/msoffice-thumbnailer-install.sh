#!/bin/sh
# Ms Office thumbnailer

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install libfile-mimeinfo-perl gvfs-bin unoconv imagemagick

# install helper files
wget http://bernaerts.dyndns.org/download/gnome/thumbnailer/msoffice-thumbnailer-icons.zip
sudo unzip -d /usr/local/sbin msoffice-thumbnailer-icons.zip
rm msoffice-thumbnailer-icons.zip

# install main script
sudo wget -O /usr/local/sbin/msoffice-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/msoffice/msoffice-thumbnailer
sudo chmod +rx /usr/local/sbin/msoffice-thumbnailer

# thumbnailer integration
sudo wget -O /usr/share/thumbnailers/msoffice.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/msoffice/msoffice.thumbnailer
