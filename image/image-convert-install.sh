#!/usr/bin/env bash
# Add image consersion extension menu
# Uses Nautilus and Python3 wrapper

# install xdg-utils, imagemagick, dcraw and heif tools
sudo apt update
sudo apt -y install xdg-utils imagemagick dcraw libheif-examples

# remove files from previous version
sudo rm --force /usr/local/bin/image-convert-declare
sudo rm --force /usr/share/file-manager/actions/image-convert.desktop
sudo rm --force /usr/share/file-manager/actions/image-convert-*.desktop
rm --force $HOME/.local/share/file-manager/actions/image-convert-*.desktop

# main script installation
sudo wget -O /usr/local/bin/image-convert https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/image/image-convert
sudo chmod +x /usr/local/bin/image-convert

# desktop integration
mkdir --parents $HOME/.local/share/nautilus-python/extensions
wget -O $HOME/.local/share/nautilus-python/extensions/image-convert-menu.py https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/image/image-convert-menu.py
