#!/usr/bin/env bash
# LibreOffice thumbnailer installation script

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install libfile-mimeinfo-perl unzip netpbm
sudo apt -y install default-jre libreoffice-java-common

# install bubblewrap wrapper to handle Nautilus 3.26.4+ bug for external thumbnailers
sudo wget -O /usr/local/bin/bwrap https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/bwrap
sudo chmod +rx /usr/local/bin/bwrap

# create icons ressource directory
ROOT_DOCTYPE="/usr/local/sbin/lo-thumbnailer.res"
sudo mkdir "${ROOT_DOCTYPE}"

# install thumbnailer icons
ARR_DOCTYPE=( "database" "graphics" "presentation" "spreadsheet" "text" )
for DOCTYPE in "${ARR_DOCTYPE[@]}"
do
	# download document type icon
	sudo wget -O "${ROOT_DOCTYPE}/lo-${DOCTYPE}.png" "https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/libreoffice/icons/lo-${DOCTYPE}.png"

	# generate mask
	sudo bash -c "pngtopnm ${ROOT_DOCTYPE}/lo-${DOCTYPE}.png | pnmscalefixed -xysize 256 256 - > ${ROOT_DOCTYPE}/lo-${DOCTYPE}.pnm" 

	# generate alpha mask
	sudo bash -c "pngtopnm -alpha ${ROOT_DOCTYPE}/lo-${DOCTYPE}.png | pnmscalefixed -xysize 256 256 - > ${ROOT_DOCTYPE}/lo-${DOCTYPE}-alpha.pnm" 
done

# install main script
sudo wget -O /usr/local/sbin/lo-thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/libreoffice/lo-thumbnailer
sudo chmod +rx /usr/local/sbin/lo-thumbnailer

# thumbnailer integration
sudo wget -O /usr/share/thumbnailers/lo.thumbnailer https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/thumbnailer/libreoffice/lo.thumbnailer

# if present, disable gsf-office.thumbnailer (used in UbuntuGnome 16.04)
[ -f "/usr/share/thumbnailers/gsf-office.thumbnailer" ] && sudo mv /usr/share/thumbnailers/gsf-office.thumbnailer /usr/share/thumbnailers/gsf-office.thumbnailer.org

# stop nautilus
nautilus -q

# remove previously cached files (thumbnails and masks)
[ -d "$HOME/.cache/thumbnails" ] && rm --recursive --force $HOME/.cache/thumbnails/*
[ -d "$HOME/.thumbnails" ] && rm --recursive --force $HOME/.thumbnails/*
