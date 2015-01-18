#!/bin/sh
# Video rotation and stabilization

# install melt, x264 and vidstab
sudo add-apt-repository ppa:sunab/kdenlive-release
sudo apt-get update
sudo apt-get install melt x264 libvidstab1.0

# install yad
sudo add-apt-repository ppa:webupd8team/y-ppa-manager
sudo apt-get update
sudo apt-get install yad

# install exiftool
sudo apt-get install libimage-exiftool-perl

sudo wget -O /usr/local/bin/video-stabilize https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-stabilize
sudo chmod +x /usr/local/bin/video-stabilize
sudo wget -O /usr/share/icons/stabilizer.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/stabilizer.png
sudo wget -O /usr/share/applications/video-stabilize.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-stabilize.desktop
mkdir --parents $HOME/.local/share/file-manager/actions
wget -O $HOME/.local/share/file-manager/actions/video-stabilize-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-stabilize-action.desktop
