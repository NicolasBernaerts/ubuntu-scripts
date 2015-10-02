#!/bin/sh
# Android device screenshot utility

# install packages
sudo apt-get -y install yad avconv android-tools-adb

# main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/android-screenshot https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/android/android-screenshot
sudo chmod +x /usr/local/bin/android-screenshot

# configuration file
wget --header='Accept-Encoding:none' -O $HOME/.android-screenshot.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/android/android-screenshot.conf

# desktop integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/applications/android-screenshot.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/android/android-screenshot.desktop
