#!/bin/sh
# APK thumbnailer

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install gvfs-bin aapt unzip netpbm

# install bubblewrap wrapper to handle Nautilus 3.26.4+ bug for external thumbnailers
sudo wget -O /usr/local/bin/bwrap https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/bwrap
sudo chmod +rx /usr/local/bin/bwrap

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/apk-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/apk/apk-thumbnailer
sudo chmod +x /usr/local/sbin/apk-thumbnailer

# thumbnailer integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/thumbnailers/apk.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/apk/apk.thumbnailer

# stop nautilus
nautilus -q

# empty cache of previous thumbnails
[ -d "$HOME/.cache/thumbnails" ] && rm --recursive --force $HOME/.cache/thumbnails/*
[ -d "$HOME/.thumbnails" ] && rm --recursive --force $HOME/.thumbnails/*
