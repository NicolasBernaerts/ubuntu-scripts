#!/bin/sh
# Convert any video file to MKV with AAC audio

# install mediainfo and mkvtoolnix
sudo apt-get -y install mediainfo mkvtoolnix

# install fdkaac encoder
sudo add-apt-repository -y ppa:mc3man/fdkaac-encoder
sudo apt-get update
sudo apt-get -y install fdkaac-encoder aac-enc

# if nautilus present, install nautilus-actions
command -v nautilus >/dev/null 2>&1 && sudo apt-get -y install nautilus-actions
mkdir --parents $HOME/.local/share/file-manager/actions

# install scripts
sudo wget -O /usr/local/bin/video-convert2mkv https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-convert2mkv
sudo chmod +x /usr/local/bin/video-convert2mkv
sudo wget -O /usr/share/applications/video-convert2mkv.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-convert2mkv.desktop
wget -O $HOME/.local/share/file-manager/actions/video-convert2mkv-action.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/video-convert2mkv-action.desktop
