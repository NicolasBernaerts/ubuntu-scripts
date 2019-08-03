#!/bin/sh
# Desktop interaction display

# desktop session environment
sudo wget --header='Accept-Encoding:none' -O /etc/profile.d/desktop-session.sh https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/desktop/desktop-session.sh
sudo chmod +x /etc/profile.d/desktop-session.sh

# main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/desktop-display https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/desktop/desktop-display
sudo chmod +x /usr/local/sbin/desktop-display
