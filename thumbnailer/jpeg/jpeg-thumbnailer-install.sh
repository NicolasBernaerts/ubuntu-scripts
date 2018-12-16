#!/bin/sh
# Installation script for very fast JPEG thumbnailer with camera and location tag display
# Based on epeg

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt -y install exiftool libjpeg-turbo-progs netpbm

# install compilation tools
sudo apt -y install build-essential cmake nasm git autoconf libtool

# install development libraries
sudo apt -y install libjpeg-turbo8-dev libexif-dev

# install bubblewrap wrapper to handle Nautilus 3.26.4+ bug for external thumbnailers
sudo wget -O /usr/local/bin/bwrap https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/bwrap
sudo chmod +rx /usr/local/bin/bwrap

# install main thumbnailer script
sudo wget -O /usr/local/sbin/jpeg-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/jpeg/jpeg-thumbnailer
sudo chmod +rx /usr/local/sbin/jpeg-thumbnailer

# thumbnailer integration
sudo wget -O /usr/share/thumbnailers/jpeg.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/jpeg/jpeg.thumbnailer

# create icons ressource directory
ROOT_DOCTYPE="/usr/local/sbin/jpeg-thumbnailer.res"
sudo mkdir "${ROOT_DOCTYPE}"

# tag and camera icons
ARR_ICON=( "none" "gps" )
ARR_ICON=( "${ARR_ICON[@]}" "canon eos m3" "canon eos 1000d" "canon eos 1100d" "canon powershot g7 x" "dmc-fz200" "dmc-tz5" )
ARR_ICON=( "${ARR_ICON[@]}" "oneplus e1003" "oneplus a0001" "one a2003" "oneplus a3003" "oneplus a5000" "oneplus a6000" "oneplus a6003" )
ARR_ICON=( "${ARR_ICON[@]}" "pixel 2 xl" "hero" "hero4 session" "lg-h870" )
for ICON in "${ARR_ICON[@]}"
do
	# download document type icon
	sudo wget -O "${ROOT_DOCTYPE}/${ICON}.png" "https://raw.githubusercontent.com/NicolasBernaerts/icon/master/camera/${ICON}.png"

	# generate mask
	sudo bash -c "pngtopnm ${ROOT_DOCTYPE}/${ICON}.png | pnmscalefixed -xysize 256 256 - > ${ROOT_DOCTYPE}/${ICON}.pnm" 

	# generate alpha mask
	sudo bash -c "pngtopnm -alpha ${ROOT_DOCTYPE}/${ICON}.png | pnmscalefixed -xysize 256 256 - > ${ROOT_DOCTYPE}/${ICON}-alpha.pnm" 
done

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

# stop nautilus
nautilus -q

# remove previously cached files (thumbnails and masks)
[ -d "$HOME/.cache/thumbnails" ] && rm --recursive --force $HOME/.cache/thumbnails/*
