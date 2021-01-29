#!/usr/bin/env bash
# Streaming video services

# Netflix
sudo wget -O /usr/share/icons/netflix.png https://github.com/NicolasBernaerts/icon/raw/master/video/netflix.png
sudo wget -O /usr/share/applications/netflix.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/netflix.desktop
sudo chmod +x /usr/share/applications/netflix.desktop

# Prime Video
sudo wget -O /usr/share/icons/amazon-video.png https://github.com/NicolasBernaerts/icon/raw/master/video/amazon-video.png
sudo wget -O /usr/share/applications/amazon-video.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/amazon-video.desktop
sudo chmod +x /usr/share/applications/amazon-video.desktop

# Molotov
sudo wget -O /usr/share/icons/molotov.png https://github.com/NicolasBernaerts/icon/raw/master/video/molotov.png
sudo wget -O /usr/local/bin/molotov.AppImage https://desktop-auto-upgrade.molotov.tv/linux/4.4.0/molotov.AppImage
sudo chmod +x /usr/local/bin/molotov.AppImage
sudo wget -O /usr/share/applications/molotov.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/molotov.desktop
sudo chmod +x /usr/share/applications/molotov.desktop
