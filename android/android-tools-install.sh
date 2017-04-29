#!/bin/sh
# Android Platform Tools installation

# download zip from Google
wget --header='Accept-Encoding:none' https://dl.google.com/android/repository/platform-tools-latest-linux.zip

# extract to /usr/local/sbin
sudo unzip -d /usr/local/sbin platform-tools-latest-linux.zip

# download adb launcher
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/adb https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/android/adb
sudo chmod +x /usr/local/sbin/adb

# download fastboot launcher
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/fastboot https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/android/fastboot
sudo chmod +x /usr/local/sbin/fastboot
