#!/bin/sh
# -----------------------------------------
# Graphviz thumbnailer installation script
# Should be compatible with 
#   Ubuntu, Debian and Linux Mint (thanks to kafeenstra)
# -----------------------------------------

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" -a "${DISTRO}" != "Debian" -a "${DISTRO}" != "Linuxmint" ] && { zenity --error --text="This  installation script is for Ubuntu, Debian or Linux Mint"; exit 1; }

# install tools
sudo apt-get -y install graphviz netpbm eog

# install bubblewrap wrapper to handle Nautilus 3.26.4+ bug for external thumbnailers
sudo wget -O /usr/local/bin/bwrap https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/nautilus/bwrap
sudo chmod +rx /usr/local/bin/bwrap

# install previewer
sudo wget -O /usr/share/icons/graphviz.png https://raw.githubusercontent.com/NicolasBernaerts/icon/refs/heads/master/graphviz.png
sudo wget -O /usr/local/bin/graphviz-preview https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/thumbnailer/graphviz/graphviz-preview
sudo chmod +x /usr/local/bin/graphviz-preview

# desktop integration
sudo wget -O /usr/share/applications/graphviz.desktop https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/thumbnailer/graphviz/graphviz.desktop
sudo chmod +x /usr/share/applications/graphviz.desktop

# install main thumnailer script
sudo wget -O /usr/local/sbin/graphviz-thumbnailer https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/thumbnailer/graphviz/graphviz-thumbnailer
sudo chmod +x /usr/local/sbin/graphviz-thumbnailer

# thumbnailer integration
sudo wget -O /usr/share/thumbnailers/graphviz.thumbnailer https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/thumbnailer/graphviz/graphviz.thumbnailer

# stop file manager
FILE_MANAGER=$(basename $(which nautilus))
[ "${FILE_MANAGER}" = "" ] && FILE_MANAGER=$(basename $(which nemo))
[ "${FILE_MANAGER}" = "" ] && FILE_MANAGER=$(basename $(which dolphin))
"${FILE_MANAGER}" -q

# empty cache of previous thumbnails
[ -d "$HOME/.cache/thumbnails" ] && rm --recursive --force $HOME/.cache/thumbnails/*
[ -d "$HOME/.thumbnails" ] && rm --recursive --force $HOME/.thumbnails/*
