#!/bin/sh
# -----------------------------------------
# APK files thumbnailer installation script
# Should be compatible with 
#   Ubuntu, Debian and Linux Mint (thanks to kafeenstra)
# -----------------------------------------

# test distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" -a "${DISTRO}" != "Debian" -a "${DISTRO}" != "Linuxmint" ] && { zenity --error --text="This installation script is for Ubuntu, Debian or Linux Mint"; exit 1; }

# install tools
sudo apt-get -y install aapt unzip netpbm

# install bubblewrap wrapper to handle Nautilus 3.26.4+ bug for external thumbnailers
sudo wget -O /usr/local/bin/bwrap https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/nautilus/bwrap
sudo chmod +rx /usr/local/bin/bwrap

# install main script
sudo wget -O /usr/local/sbin/apk-thumbnailer https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/thumbnailer/apk/apk-thumbnailer
sudo chmod +x /usr/local/sbin/apk-thumbnailer

# thumbnailer integration
sudo wget -O /usr/share/thumbnailers/apk.thumbnailer https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/thumbnailer/apk/apk.thumbnailer

# stop file manager
FILE_MANAGER=$(basename $(which nautilus))
[ "${FILE_MANAGER}" = "" ] && FILE_MANAGER=$(basename $(which nemo))
[ "${FILE_MANAGER}" = "" ] && FILE_MANAGER=$(basename $(which dolphin))
[ "${FILE_MANAGER}" != "" ] && "${FILE_MANAGER}" -q

# empty cache of previous thumbnails
[ -d "$HOME/.cache/thumbnails" ] && rm --recursive --force $HOME/.cache/thumbnails/*
[ -d "$HOME/.thumbnails" ] && rm --recursive --force $HOME/.thumbnails/*
