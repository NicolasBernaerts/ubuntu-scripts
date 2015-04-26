#!/bin/sh
# Graphviz thumbnailer

sudo apt-get -y install graphviz imagemagick default-jre
wget http://downloads.sourceforge.net/project/zvtm/zgrviewer/0.10.0/zgrviewer-0.10.0.zip
sudo unzip -d /opt zgrviewer-*.zip
sudo mv /opt/zgrviewer-* /opt/zgrviewer
sed 's/^ZGRV_HOME=./ZGRV_HOME=\/opt\/zgrviewer/' /opt/zgrviewer/run.sh | sudo tee /opt/zgrviewer/zgrviewer.sh
sudo chmod +x /opt/zgrviewer/zgrviewer.sh
rm zgrviewer-*.zip

sudo wget -O /usr/share/icons/graphviz.png http://bernaerts.dyndns.org/download/ubuntu/graphviz/text-vnd.graphviz.png

sudo wget -O /usr/share/applications/graphviz.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/graphviz/graphviz.desktop
sudo chmod +x /usr/share/applications/graphviz.desktop
xdg-mime default graphviz.desktop text/vnd.graphviz

sudo wget -O /usr/local/sbin/graphviz-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/graphviz/graphviz-thumbnailer
sudo chmod +x /usr/local/sbin/graphviz-thumbnailer
sudo wget -O /usr/share/thumbnailers/graphviz.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/graphviz/graphviz.thumbnailer
