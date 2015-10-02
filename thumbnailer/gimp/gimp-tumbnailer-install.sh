#!/bin/sh
# GIMP XCF thumbnailer

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install gvfs-bin imagemagick xcftools

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/gimp-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/gimp/gimp-thumbnailer
sudo chmod +x /usr/local/sbin/gimp-thumbnailer

# thumbnailer integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/thumbnailers/gimp.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/gimp/gimp.thumbnailer
