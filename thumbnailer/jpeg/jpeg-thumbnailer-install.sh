#!/bin/sh
# Very fast JPEG thumbnailer with camera and location tag display

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt -y install exiftool libjpeg-turbo-progs netpbm

# install compilation tools
sudo apt -y install build-essential cmake nasm git autoconf libtool

# install development libraries
sudo apt install libjpeg-turbo8-dev libexif-dev

# compile epeg
mkdir ~/sources
cd ~/sources
git clone https://github.com/mattes/epeg.git
cd epeg
libtoolize
autoreconf -i
./configure
make
sudo make install

# install thumbnailer icons
sudo mkdir /usr/local/sbin/jpeg-thumbnailer.res
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/jpeg-thumbnailer.res/location.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/jpeg/location.png
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/jpeg-thumbnailer.res/none.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/jpeg/none.png

# install main thumbnailer script
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/jpeg-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/jpeg/jpeg-thumbnailer
sudo chmod +rx /usr/local/sbin/jpeg-thumbnailer

# thumbnailer integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/thumbnailers/jpeg.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/jpeg/jpeg.thumbnailer

# camera icons
sudo mkdir --parents $HOME/.local/share/icons
wget --header='Accept-Encoding:none' -O "$HOME/.local/share/icons/dmc-fz200.png" "https://raw.githubusercontent.com/NicolasBernaerts/icon/master/camera/dmc-fz200.png"
wget --header='Accept-Encoding:none' -O "$HOME/.local/share/icons/dmc-tz5.png" "https://raw.githubusercontent.com/NicolasBernaerts/icon/master/camera/dmc-tz5.png"
wget --header='Accept-Encoding:none' -O "$HOME/.local/share/icons/oneplus a2000.png" "https://raw.githubusercontent.com/NicolasBernaerts/icon/master/camera/oneplus a2000.png"
wget --header='Accept-Encoding:none' -O "$HOME/.local/share/icons/oneplus a3003.png" "https://raw.githubusercontent.com/NicolasBernaerts/icon/master/camera/oneplus a3003.png"
wget --header='Accept-Encoding:none' -O "$HOME/.local/share/icons/oneplus a5000.png" "https://raw.githubusercontent.com/NicolasBernaerts/icon/master/camera/oneplus a5000.png"

# stop nautilus
nautilus -q

# remove previous thumbnails
rm -R $HOME/.cache/thumbnails/*
