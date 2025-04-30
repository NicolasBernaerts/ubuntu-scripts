#!/usr/bin/env bash
# Ms Office thumbnailer installation script

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install libfile-mimeinfo-perl netpbm
sudo apt install default-jre libreoffice-java-common

# install bubblewrap wrapper to handle Nautilus 3.26.4+ bug for external thumbnailers
sudo wget -O /usr/local/bin/bwrap https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/nautilus/bwrap
sudo chmod +rx /usr/local/bin/bwrap

# create icons ressource directory
ROOT_DOCTYPE="/usr/local/sbin/msoffice-thumbnailer.res"
sudo mkdir "${ROOT_DOCTYPE}"

# install thumbnailer icons
ARR_DOCTYPE=( "odt" "ods" "odp" )
for DOCTYPE in "${ARR_DOCTYPE[@]}"
do
	# download document type icon
	sudo wget -O "${ROOT_DOCTYPE}/msoffice-${DOCTYPE}.png" "https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/thumbnailer/msoffice/icons/msoffice-${DOCTYPE}.png"

	# generate mask
	sudo bash -c "pngtopnm ${ROOT_DOCTYPE}/msoffice-${DOCTYPE}.png | pnmscalefixed -xysize 256 256 - > ${ROOT_DOCTYPE}/msoffice-${DOCTYPE}.pnm" 

	# generate alpha mask
	sudo bash -c "pngtopnm -alpha ${ROOT_DOCTYPE}/msoffice-${DOCTYPE}.png | pnmscalefixed -xysize 256 256 - > ${ROOT_DOCTYPE}/msoffice-${DOCTYPE}-alpha.pnm" 
done

# install main script
sudo wget -O /usr/local/sbin/msoffice-thumbnailer https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/thumbnailer/msoffice/msoffice-thumbnailer
sudo chmod +rx /usr/local/sbin/msoffice-thumbnailer

# thumbnailer integration
sudo wget -O /usr/share/thumbnailers/msoffice.thumbnailer https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/thumbnailer/msoffice/msoffice.thumbnailer

# if present, disable gsf-office.thumbnailer (used in UbuntuGnome 16.04)
[ -f /usr/share/thumbnailers/gsf-office.thumbnailer ] && sudo mv /usr/share/thumbnailers/gsf-office.thumbnailer /usr/share/thumbnailers/gsf-office.thumbnailer.org

# stop nautilus
nautilus -q

# remove previously cached files (thumbnails and masks)
[ -d "$HOME/.cache/thumbnails" ] && rm --recursive --force $HOME/.cache/thumbnails/*
[ -d "$HOME/.thumbnails" ] && rm --recursive --force $HOME/.thumbnails/*
