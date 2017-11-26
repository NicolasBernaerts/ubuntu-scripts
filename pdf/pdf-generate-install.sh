#!/bin/sh
# Install PDF generate extension

# if nautilus present, install nautilus-actions
command -v nautilus >/dev/null 2>&1 && sudo apt-get -y install nautilus-actions

# main packages installation
sudo apt-get -y install imagemagick unoconv ghostscript zenity libfile-mimeinfo-perl wkhtmltopdf

# show icon in menus
gsettings set org.gnome.desktop.interface menus-have-icons true

# install icons
sudo wget --header='Accept-Encoding:none' -O /usr/share/icons/pdf-generate.png https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/pdf/icons/pdf-generate.png

# install configuration file 
mkdir --parents $HOME/.config
wget --header='Accept-Encoding:none' -O $HOME/.config/pdf-generate.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-generate.conf

# main script installation
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/pdf-generate https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-generate
sudo chmod +x /usr/local/bin/pdf-generate

# desktop integration
mkdir --parents $HOME/.local/share/file-manager/actions
wget --header='Accept-Encoding:none' -O $HOME/.local/share/file-manager/actions/pdf-generate-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/pdf/pdf-generate-action.desktop
