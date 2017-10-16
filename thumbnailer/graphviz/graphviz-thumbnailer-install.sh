#!/bin/sh
# Graphviz thumbnailer

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install graphviz netpbm eog

# install previewer
sudo wget --header='Accept-Encoding:none' -O /usr/share/icons/graphviz.png http://bernaerts.dyndns.org/download/ubuntu/graphviz/text-vnd.graphviz.png
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/graphviz-preview https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/graphviz/graphviz-preview
sudo chmod +x /usr/local/bin/graphviz-preview

# desktop integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/applications/graphviz.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/graphviz/graphviz.desktop
sudo chmod +x /usr/share/applications/graphviz.desktop

# install main thumnailer script
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/graphviz-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/graphviz/graphviz-thumbnailer
sudo chmod +x /usr/local/sbin/graphviz-thumbnailer

# thumbnailer integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/thumbnailers/graphviz.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/graphviz/graphviz.thumbnailer

# stop nautilus
nautilus -q

# empty cache of previous thumbnails
[ -d "$HOME/.cache/thumbnails" ] && rm -R $HOME/.cache/thumbnails/*
[ -d "$HOME/.thumbnails" ] && rm -R $HOME/.thumbnails/*
