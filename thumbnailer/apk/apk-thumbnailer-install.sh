#!/bin/sh
# APK thumbnailer

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install libfile-mimeinfo-perl gvfs-bin unzip imagemagick python-nautilus

# install aapt
sudo apt-get -y install aapt

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/apk-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/apk/apk-thumbnailer
sudo chmod +x /usr/local/sbin/apk-thumbnailer

# thumbnailer integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/thumbnailers/apk.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/apk/apk.thumbnailer
