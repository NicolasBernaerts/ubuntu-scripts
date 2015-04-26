#!/bin/sh
# Graphviz thumbnailer

sudo apt-get -y install graphviz imagemagick

sudo wget -O /usr/local/bin/graphviz-preview https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/graphviz/graphviz-preview
sudo chmod +x /usr/local/bin/graphviz-preview
sudo wget -O /usr/share/applications/graphviz.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/graphviz/graphviz.desktop
sudo chmod +x /usr/share/applications/graphviz.desktop

sudo wget -O /usr/local/bin/graphviz-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/graphviz/graphviz-thumbnailer
sudo chmod +x /usr/local/bin/graphviz-thumbnailer
sudo wget -O /usr/share/thumbnailers/graphviz.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/graphviz/graphviz.thumbnailer
