#!/bin/sh
# Android device screenshot utility

sudo apt-get -y install yad avconv android-tools-adb
sudo wget -O /usr/local/bin/android-screenshot https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/android/android-screenshot
sudo chmod +x /usr/local/bin/android-screenshot
sudo wget -O /usr/share/applications/android-screenshot.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/android/android-screenshot.desktop
wget -O $HOME/.android-screenshot.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/android/android-screenshot.conf
