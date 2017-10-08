#!/bin/bash
# -------------------------------------------------------
# Script to install Sweet Home 3D
# -------------------------------------------------------

# sweethome3d
sudo apt-get -y install libjava3d-java

# install latest version under $HOME/.local/apps/SweetHome3D
wget -O sweethome3d.tgz https://kent.dl.sourceforge.net/project/sweethome3d/SweetHome3D/SweetHome3D-5.5.2/SweetHome3D-5.5.2-linux-x64.tgz
tar -xvf sweethome3d.tgz
sudo mv SweetHome3D-* /opt/sweethome3d
rm ./sweethome3d.tgz

# install sweethome3d project icon
sudo wget -O "/usr/share/icons/sweethome3d.png" https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/tools/sweethome3d/sweethome3d.png

# declare sweethome3d mimetype
sudo wget -O "/usr/share/mime/packages/sweethome3d.xml" https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tools/sweethome3d/sweethome3d.xml
sudo update-mime-database /usr/share/mime

# declare desktop file
sudo wget /usr/share/applications/sweethome3d.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tools/sweethome3d.desktop
sudo chmod +x /usr/share/applications/sweethome3d.desktop

# associate mimetype to desktop file
ASSOCIATION=$(grep "application/sweethome3d=" "$HOME/.local/share/applications/mimeapps.list")
[ "${ASSOCIATION}" = "" ] && echo "application/sweethome3d=sweethome3d.desktop" >> "$HOME/.local/share/applications/mimeapps.list"
