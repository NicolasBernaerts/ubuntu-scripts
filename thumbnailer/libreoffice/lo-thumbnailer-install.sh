#!/usr/bin/env bash
# -----------------------------------------
# Libre Office thumbnailer installation script
# Should be compatible with 
#   Ubuntu, Debian and Linux Mint (thanks to kafeenstra)
# -----------------------------------------

# test distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" -a "${DISTRO}" != "Debian" -a "${DISTRO}" != "Linuxmint" ] && { zenity --error --text="This installation script is for Ubuntu, Debian or Linux Mint"; exit 1; }

# install tools
sudo apt-get -y install libfile-mimeinfo-perl unzip netpbm
sudo apt -y install default-jre libreoffice-java-common

# install bubblewrap wrapper to handle Nautilus 3.26.4+ bug for external thumbnailers
sudo wget -O /usr/local/bin/bwrap https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/nautilus/bwrap
sudo chmod +rx /usr/local/bin/bwrap

# create icons ressource directory
ROOT_DOCTYPE="/usr/local/sbin/lo-thumbnailer.res"
sudo mkdir "${ROOT_DOCTYPE}"

# install thumbnailer icons
ARR_DOCTYPE=( "database" "graphics" "presentation" "spreadsheet" "text" )
for DOCTYPE in "${ARR_DOCTYPE[@]}"
do
	# download document type icon
	sudo wget -O "${ROOT_DOCTYPE}/lo-${DOCTYPE}.png" "https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/thumbnailer/libreoffice/icons/lo-${DOCTYPE}.png"

	# generate mask
	sudo bash -c "pngtopnm ${ROOT_DOCTYPE}/lo-${DOCTYPE}.png | pnmscalefixed -xysize 256 256 - > ${ROOT_DOCTYPE}/lo-${DOCTYPE}.pnm" 

	# generate alpha mask
	sudo bash -c "pngtopnm -alpha ${ROOT_DOCTYPE}/lo-${DOCTYPE}.png | pnmscalefixed -xysize 256 256 - > ${ROOT_DOCTYPE}/lo-${DOCTYPE}-alpha.pnm" 
done

# install main script
sudo wget -O /usr/local/sbin/lo-thumbnailer https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/thumbnailer/libreoffice/lo-thumbnailer
sudo chmod +rx /usr/local/sbin/lo-thumbnailer

# thumbnailer integration
sudo wget -O /usr/share/thumbnailers/lo.thumbnailer https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/thumbnailer/libreoffice/lo.thumbnailer

# if present, disable gsf-office.thumbnailer
[ -f "/usr/share/thumbnailers/gsf-office.thumbnailer" ] && sudo mv /usr/share/thumbnailers/gsf-office.thumbnailer /usr/share/thumbnailers/gsf-office.thumbnailer.org

# stop file manager
FILE_MANAGER=$(basename $(which nautilus))
[ "${FILE_MANAGER}" = "" ] && FILE_MANAGER=$(basename $(which nemo))
[ "${FILE_MANAGER}" = "" ] && FILE_MANAGER=$(basename $(which dolphin))
[ "${FILE_MANAGER}" != "" ] && "${FILE_MANAGER}" -q

# remove previously cached files (thumbnails and masks)
[ -d "$HOME/.cache/thumbnails" ] && rm --recursive --force $HOME/.cache/thumbnails/*
[ -d "$HOME/.thumbnails" ] && rm --recursive --force $HOME/.thumbnails/*
