#!/bin/sh
# Android Platform Tools installation

# install adb and fastboot
sudo apt-get -y install android-tools-adb android-tools-fastboot

# install latest version from Google
wget --header='Accept-Encoding:none' https://dl.google.com/android/repository/platform-tools-latest-linux.zip
sudo unzip -d /usr/local/sbin platform-tools-latest-linux.zip
rm platform-tools-latest-linux.zip

# launcher for latest adb
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/adb https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/android/adb
sudo chmod +x /usr/local/sbin/adb

# launcher for latest fastboot
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/fastboot https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/android/fastboot
sudo chmod +x /usr/local/sbin/fastboot
