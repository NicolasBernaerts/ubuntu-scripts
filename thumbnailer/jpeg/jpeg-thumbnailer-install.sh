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
sudo apt -y install libjpeg-turbo8-dev libexif-dev

# compile and install epeg
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
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/jpeg-thumbnailer.res/gps.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/jpeg/gps.png
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/jpeg-thumbnailer.res/none.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/jpeg/none.png

# install main thumbnailer script
sudo wget --header='Accept-Encoding:none' -O /usr/local/sbin/jpeg-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/jpeg/jpeg-thumbnailer
sudo chmod +rx /usr/local/sbin/jpeg-thumbnailer

# thumbnailer integration
sudo wget --header='Accept-Encoding:none' -O /usr/share/thumbnailers/jpeg.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/jpeg/jpeg.thumbnailer

# camera icons
sudo mkdir --parents $HOME/.local/share/icons
wget --header='Accept-Encoding:none' -O "$HOME/.local/share/icons/canon eos 1000d.png" "https://raw.githubusercontent.com/NicolasBernaerts/icon/master/camera/canon eos 1000d.png"
wget --header='Accept-Encoding:none' -O "$HOME/.local/share/icons/canon eos 1100d.png" "https://raw.githubusercontent.com/NicolasBernaerts/icon/master/camera/canon eos 1100d.png"
wget --header='Accept-Encoding:none' -O "$HOME/.local/share/icons/canon powershot g7 x.png" "https://raw.githubusercontent.com/NicolasBernaerts/icon/master/camera/canon powershot g7 x.png"
wget --header='Accept-Encoding:none' -O "$HOME/.local/share/icons/dmc-fz200.png" "https://raw.githubusercontent.com/NicolasBernaerts/icon/master/camera/dmc-fz200.png"
wget --header='Accept-Encoding:none' -O "$HOME/.local/share/icons/dmc-tz5.png" "https://raw.githubusercontent.com/NicolasBernaerts/icon/master/camera/dmc-tz5.png"
wget --header='Accept-Encoding:none' -O "$HOME/.local/share/icons/oneplus e1003.png" "https://raw.githubusercontent.com/NicolasBernaerts/icon/master/camera/oneplus e1003.png"
wget --header='Accept-Encoding:none' -O "$HOME/.local/share/icons/oneplus a0001.png" "https://raw.githubusercontent.com/NicolasBernaerts/icon/master/camera/oneplus a0001.png"
wget --header='Accept-Encoding:none' -O "$HOME/.local/share/icons/one a2003.png" "https://raw.githubusercontent.com/NicolasBernaerts/icon/master/camera/one a2003.png"
wget --header='Accept-Encoding:none' -O "$HOME/.local/share/icons/oneplus a3003.png" "https://raw.githubusercontent.com/NicolasBernaerts/icon/master/camera/oneplus a3003.png"
wget --header='Accept-Encoding:none' -O "$HOME/.local/share/icons/oneplus a5000.png" "https://raw.githubusercontent.com/NicolasBernaerts/icon/master/camera/oneplus a5000.png"

# stop nautilus
nautilus -q

# remove previously cached files (thumbnails and masks)
[ -d "$HOME/.cache/thumbnails" ] && rm -R $HOME/.cache/thumbnails/*
[ -d "$HOME/.cache/jpeg-thumbnailer" ] && rm -R $HOME/.cache/jpeg-thumbnailer/*
