#!/usr/bin/env bash
# Add image consersion extension menu to Nautilus

# test Nautilus
command -v nautilus >/dev/null 2>&1 || { echo "Nautilus has not been detected. Please install it first."; exit 1; }

# install nautilus-actions, xdg-utils, imagemagick and dcraw
sudo apt-get update
sudo apt-get -y install nautilus-actions xdg-utils imagemagick dcraw

# nautilus : remove nautilus action root menu
mv $HOME/.config/nautilus-actions/nautilus-actions.conf $HOME/.config/nautilus-actions/nautilus-actions.conf.org
cat $HOME/.config/nautilus-actions/nautilus-actions.conf.org | sed 's/items-create-root-menu=.*/items-create-root-menu=false/' > $HOME/.config/nautilus-actions/nautilus-actions.conf

# install image-convert scripts
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/image-convert https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-convert
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/image-convert-declare https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-convert-declare
sudo chmod +x /usr/local/bin/image-convert
sudo chmod +x /usr/local/bin/image-convert-declare

# install .conf configuration file
wget --header='Accept-Encoding:none' -O "$HOME/.config/image-convert.conf" https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/image/image-convert.conf

# declare image-convert nautilus extension
/usr/local/bin/image-convert-declare --install
