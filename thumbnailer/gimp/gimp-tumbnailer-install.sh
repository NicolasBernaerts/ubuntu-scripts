#!/bin/sh
# GIMP XCF thumbnailer installation script

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt -y install netpbm

# install bubblewrap wrapper to handle Nautilus 3.26.4+ bug for external thumbnailers
[ ! -f /usr/local/bin/bwrap ] && sudo wget -O /usr/local/bin/bwrap https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/nautilus/bwrap
sudo chmod +rx /usr/local/bin/bwrap

# install main script
sudo wget -O /usr/local/sbin/gimp-thumbnailer https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/thumbnailer/gimp/gimp-thumbnailer
sudo chmod +x /usr/local/sbin/gimp-thumbnailer

# thumbnailer integration
sudo wget -O /usr/share/thumbnailers/gimp.thumbnailer https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/thumbnailer/gimp/gimp.thumbnailer

# stop nautilus
nautilus -q

# empty cache of previous thumbnails
[ -d "$HOME/.cache/thumbnails" ] && rm --recursive --force $HOME/.cache/thumbnails/*
[ -d "$HOME/.thumbnails" ] && rm --recursive --force $HOME/.thumbnails/*
