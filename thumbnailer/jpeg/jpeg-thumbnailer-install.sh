#!/usr/bin/env bash
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
sudo wget -O /usr/local/bin/bwrap https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/nautilus/bwrap
sudo chmod +rx /usr/local/bin/bwrap

# install main thumbnailer script
sudo wget -O /usr/local/sbin/jpeg-thumbnailer https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/thumbnailer/jpeg/jpeg-thumbnailer
sudo chmod +rx /usr/local/sbin/jpeg-thumbnailer

# thumbnailer integration
sudo wget -O /usr/share/thumbnailers/jpeg.thumbnailer https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/thumbnailer/jpeg/jpeg.thumbnailer

# create icons ressource directory
ROOT_ICON="/usr/local/sbin/jpeg-thumbnailer.res"
[ ! -d "${ROOT_ICON}" ] && sudo mkdir "${ROOT_ICON}"

# download transparent icon and generate alpha
sudo wget -O "${ROOT_ICON}/none.png" "https://github.com/NicolasBernaerts/icon/raw/refs/heads/master/camera/none.png"
sudo bash -c "pngtopnm -alpha '${ROOT_ICON}/none.png' | pnmscalefixed -ysize 64 - > '${ROOT_ICON}/none-alpha.pnm'" 

# download gps icon and generate mask / alpha
sudo wget -O "${ROOT_ICON}/gps.png" "https://github.com/NicolasBernaerts/icon/raw/refs/heads/master/camera/gps.png"
sudo bash -c "pngtopnm '${ROOT_ICON}/gps.png' | pnmscalefixed -ysize 64 - > '${ROOT_ICON}/gps.pnm'" 
sudo bash -c "pngtopnm -alpha '${ROOT_ICON}/gps.png' | pnmscalefixed -ysize 64 - > '${ROOT_ICON}/gps-alpha.pnm'" 


# list of supported cameras
ARR_ICON=( "canon eos m3" "canon eos 1000d" "canon eos 1100d" "canon powershot g7 x" "dmc-fz200" "dmc-tz5" )
ARR_ICON=( "${ARR_ICON[@]}" "oneplus e1003" "oneplus a0001" "one a2003" "oneplus a3003" "oneplus a5000" )
ARR_ICON=( "${ARR_ICON[@]}" "oneplus a6000" "oneplus a6003" "hd1903" )
ARR_ICON=( "${ARR_ICON[@]}" "pixel 2 xl" "hero" "hero4 session" "lg-h870" )

# loop to install icons, masks and alpha masks
for ICON in "${ARR_ICON[@]}"
do
	# download document type icon
	sudo wget -O "${ROOT_ICON}/${ICON}.png" "https://github.com/NicolasBernaerts/icon/raw/refs/heads/master/camera/${ICON}.png"

	# generate mask
	sudo bash -c "pngtopnm '${ROOT_ICON}/${ICON}.png' | pnmscalefixed -ysize 64 - > '${ROOT_ICON}/${ICON}.pnm'" 

	# generate alpha mask
	sudo bash -c "pngtopnm -alpha '${ROOT_ICON}/${ICON}.png' | pnmscalefixed -ysize 64 - > '${ROOT_ICON}/${ICON}-alpha.pnm'" 
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
