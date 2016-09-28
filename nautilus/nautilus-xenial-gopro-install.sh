#!/usr/bin/env bash
# Installation of updated gphoto libraries to avoid corrupted DCIM with latest GoPro

# remove targeted files and directories 
sudo rm -f /usr/lib/x86_64-linux-gnu/libgphoto2_port.so.12
sudo rm -R /usr/lib/x86_64-linux-gnu/libgphoto2_port/0.12.0
sudo rm -f /usr/lib/x86_64-linux-gnu/libgphoto2.so.6
sudo rm -R /usr/lib/x86_64-linux-gnu/libgphoto2/2.5.10
sudo rm -f /lib/udev/hwdb.d/20-libgphoto2-6.hwdb

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

# remove downloaded packages
rm libgphoto2-port12_2.5.10-3_amd64.deb libgphoto2-6_2.5.10-3_amd64.deb

# restart udev service
sudo udevadm hwdb --update
sudo service udev restart
