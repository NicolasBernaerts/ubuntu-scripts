#!/usr/bin/env bash
# -------------------------------------------------------------
# Installation of updated gphoto libraries to avoid corrupted DCIM with latest GoPro
#
# Revision history :
#   25/09/2016, V1.0 - Creation by N. Bernaerts
#   20/07/2017, V1.1 - Update to externalize main actions
# -------------------------------------------------------------

# create /opt/libgphoto2 directory structure
sudo mkdir --parent /opt/libgphoto2

# download main script
sudo wget -O /opt/libgphoto2/nautilus-xenial-gopro https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/nautilus-xenial-gopro
sudo chmod +x /opt/libgphoto2/nautilus-xenial-gopro

# launch installation
sudo /opt/libgphoto2/nautilus-xenial-gopro --install
