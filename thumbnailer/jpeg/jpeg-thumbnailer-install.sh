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

# update local libraries
sudo ldconfig

# install thumbnailer icons
sudo mkdir /usr/local/sbin/jpeg-thumbnailer.res
sudo wget -O /usr/local/sbin/jpeg-thumbnailer.res/gps.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/jpeg/gps.png
sudo wget -O /usr/local/sbin/jpeg-thumbnailer.res/none.png https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/jpeg/none.png

# install main thumbnailer script
sudo wget -O /usr/local/sbin/jpeg-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/jpeg/jpeg-thumbnailer
sudo chmod +rx /usr/local/sbin/jpeg-thumbnailer

# thumbnailer integration
sudo wget -O /usr/share/thumbnailers/jpeg.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/jpeg/jpeg.thumbnailer

# camera icons
mkdir --parents $HOME/.local/share/icons
ARR_ICON=( "canon eos 1000d.png" "canon eos 1100d.png" "canon powershot g7 x.png" "dmc-fz200.png" "dmc-tz5.png" )
ARR_ICON=( "${ARR_ICON[@]}" "oneplus e1003.png" "oneplus a0001.png" "one a2003.png" "oneplus a3003.png" "oneplus a5000.png" "oneplus a6000.png" )
ARR_ICON=( "${ARR_ICON[@]}" "hero.png" "hero4 session.png" "lg-h870.png" )
for ICON in "${ARR_ICON[@]}"
do
  wget -O "$HOME/.local/share/icons/${ICON}" "https://raw.githubusercontent.com/NicolasBernaerts/icon/master/camera/${ICON}"
done 

# stop nautilus
nautilus -q

# remove previously cached files (thumbnails and masks)
[ -d "$HOME/.cache/thumbnails" ] && rm --recursive --force $HOME/.cache/thumbnails/*
[ -d "$HOME/.cache/jpeg-thumbnailer" ] && rm --recursive --force $HOME/.cache/jpeg-thumbnailer/*
