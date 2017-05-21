#!/bin/bash
# Install Update Monitor Position script

# test Ubuntu or Linux Minty distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu"; exit 1; }

# install xmllint
sudo apt-get -y install libxml2-utils

# install script
sudo wget -O /usr/local/sbin/update-monitor-position https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/ubuntugnome/update-monitor-position
sudo chmod +x /usr/local/sbin/update-monitor-position

# install desktop launcher
sudo wget -O /usr/share/applications/update-monitor-position.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/ubuntugnome/update-monitor-position.desktop
sudo chmod +x /usr/share/applications/update-monitor-position.desktop

# declare autostart script
mkdir -p $HOME/.config/autostart
wget -O $HOME/.config/autostart/update-monitor-position.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/ubuntugnome/update-monitor-position.desktop
sed -i -e 's/^Exec=.*$/Exec=update-monitor-position 5/' $HOME/.config/autostart/update-monitor-position.desktop
chmod +x $HOME/.config/autostart/update-monitor-position.desktop

# delete monitor.xml
rm $HOME/.config/monitors.xml
