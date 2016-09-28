#!/usr/bin/env bash
# -------------------------------------------------------------
# Installation of updated gphoto libraries to avoid corrupted DCIM with latest GoPro
#
# Revision history :
#   25/09/2016, V1.0 - Creation by N. Bernaerts
# -------------------------------------------------------------

# -------------------------------------------------------
#   Loop to load arguments
# -------------------------------------------------------

# if no argument, display help
if [ $# -eq 0 ] 
then
  echo "Tool to install libgphoto2 2.5.10 libraries to correct latest GoPro DCIM bug under Xenial."
  echo "Parameters are :"
  echo "  --install       Install and declare the updated library"
  echo "  --remove        Back to original library"
  exit
fi

# loop to retrieve arguments
while test $# -gt 0
do
  case "$1" in
    "--install") MODE="install"; shift; ;;
    "--remove") MODE="remove"; shift; ;;
    *) shift; ;;
   esac
done

# check --install or --remove mode
[ "${MODE}" != "install" -a "${MODE}" != "remove" ] && { echo "Please use --install or --remove"; exit 1; }

# ---------------------------------------------------
#  Removal
# ---------------------------------------------------

# remove targeted files and directories 
sudo rm -f /usr/lib/x86_64-linux-gnu/libgphoto2_port.so.12
sudo rm -R /usr/lib/x86_64-linux-gnu/libgphoto2_port/0.12.0
sudo rm -f /usr/lib/x86_64-linux-gnu/libgphoto2.so.6
sudo rm -R /usr/lib/x86_64-linux-gnu/libgphoto2/2.5.10
sudo rm -f /lib/udev/hwdb.d/20-libgphoto2-6.hwdb

# ---------------------------------------------------
#  Installation mode
# ---------------------------------------------------

if [ "${MODE}" = "install" ]
then
  # create /opt/libgphoto2 directory structure
  sudo mkdir --parent /opt/libgphoto2

  # unpack and declare libgphoto2-port12
  wget http://fr.archive.ubuntu.com/ubuntu/pool/main/libg/libgphoto2/libgphoto2-port12_2.5.10-3_amd64.deb
  dpkg --fsys-tarfile libgphoto2-port12_2.5.10-3_amd64.deb | sudo tar xf - -C /opt/libgphoto2
  sudo ln -s /opt/libgphoto2/usr/lib/x86_64-linux-gnu/libgphoto2_port.so.12.0.0 /usr/lib/x86_64-linux-gnu/libgphoto2_port.so.12
  sudo ln -s /opt/libgphoto2/usr/lib/x86_64-linux-gnu/libgphoto2_port/0.12.0 /usr/lib/x86_64-linux-gnu/libgphoto2_port/0.12.0

  # unpack and declare libgphoto2
  wget http://fr.archive.ubuntu.com/ubuntu/pool/main/libg/libgphoto2/libgphoto2-6_2.5.10-3_amd64.deb
  dpkg --fsys-tarfile libgphoto2-6_2.5.10-3_amd64.deb | sudo tar xf - -C /opt/libgphoto2
  sudo ln -s /opt/libgphoto2/usr/lib/x86_64-linux-gnu/libgphoto2.so.6.0.0 /usr/lib/x86_64-linux-gnu/libgphoto2.so.6
  sudo ln -s /opt/libgphoto2/usr/lib/x86_64-linux-gnu/libgphoto2/2.5.10 /usr/lib/x86_64-linux-gnu/libgphoto2/2.5.10
  sudo ln -s /opt/libgphoto2/lib/udev/hwdb.d/20-libgphoto2-6.hwdb /lib/udev/hwdb.d/20-libgphoto2-6.hwdb

  # remove downloaded pacakges
  rm libgphoto2-port12_2.5.10-3_amd64.deb libgphoto2-6_2.5.10-3_amd64.deb

# ---------------------------------------------------
#  Removal mode
# ---------------------------------------------------

elif [ "${MODE}" = "remove" ]
then
  # remove /opt/libgphoto2 directory structure
  sudo rm -R /opt/libgphoto2

  # reinstall original packages
  sudo apt-get install --yes --reinstall libgphoto2-6 libgphoto2-port12
fi

# ---------------------------------------------------
#  Restart services
# ---------------------------------------------------

# update hardware database
sudo udevadm hwdb --update

# restart udev service
sudo service udev restart
