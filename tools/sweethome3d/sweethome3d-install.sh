#!/usr/bin/env bash
# -------------------------------------------------------
# Script to install Sweet Home 3D
# -------------------------------------------------------

# sweethome3d
sudo apt -y install libjava3d-java

# get latest linux 64 version download link from sourceforge home page (2 steps)
SITE="https://sourceforge.net"
URL="/projects/sweethome3d/files/SweetHome3D/"
wget -O "index.html" "${SITE}${URL}"
URL=$(grep "files_name_h" "index.html" | grep "sweethome3d" | head -n 1 | sed "s|^.*href=.\([^\"]*\).*$|\1|")
wget -O "index.html" "${SITE}${URL}"
URL=$(grep "files_name_h" "index.html" | grep "linux-x64" | sed "s|^.*href=.\([^\"]*\).*$|\1|")
wget -O "sweethome3d.tgz" "${URL}"
rm ./index.html

# instal it under $HOME/.local/apps/SweetHome3D
tar -xvf sweethome3d.tgz
sudo mv SweetHome3D-* /opt/sweethome3d
sudo chown -R root:root /opt/sweethome3d
rm ./sweethome3d.tgz

# install sweethome3d project icon
sudo wget -O /usr/share/icons/sweethome3d.png https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/tools/sweethome3d/sweethome3d.png

# declare sweethome3d mimetype
sudo wget -O /usr/share/mime/packages/sweethome3d.xml https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/tools/sweethome3d/sweethome3d.xml
sudo update-mime-database /usr/share/mime

# declare desktop file
sudo wget -O /usr/share/applications/sweethome3d.desktop https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/tools/sweethome3d/sweethome3d.desktop
sudo chmod +x /usr/share/applications/sweethome3d.desktop

# associate mimetype to desktop file
MIMEFILE="$HOME/.local/share/applications/mimeapps.list"
[ -f "${MIMEFILE}" ] && ASSOCIATION=$(grep "application/sweethome3d=" "${MIMEFILE}") || ASSOCIATION=""
[ "${ASSOCIATION}" = "" ] && echo "application/sweethome3d=sweethome3d.desktop" >> "${MIMEFILE}"
