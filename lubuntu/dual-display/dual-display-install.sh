#!/bin/sh
 
# place scripts to handle display change
mkdir -p $HOME/.screenlayout
wget --header='Accept-Encoding:none' -O $HOME/.screenlayout/single-display.sh https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/lubuntu/dual-display/single-display.sh
wget --header='Accept-Encoding:none' -O $HOME/.screenlayout/dual-display.sh https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/lubuntu/dual-display/dual-display.sh
 
# declare keyboard shortcut
wget --header='Accept-Encoding:none' https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/lubuntu/dual-display/dual-display.xml
sed -i -e '/<!-- Keybindings for desktop switching -->/r dual-display.xml' $HOME/.config/openbox/lubuntu-rc.xml
