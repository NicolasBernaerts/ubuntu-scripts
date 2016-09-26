#!/usr/bin/env bash
# Installation of updated gphoto libraries to avoid corrupted DCIM with latest GoPro

# create /opt/nautilus-gopro directory structure
sudo mkdir --parent /opt/nautilus-gopro/lib

# install updated libgphoto2-port12
wget http://fr.archive.ubuntu.com/ubuntu/pool/main/libg/libgphoto2/libgphoto2-port12_2.5.10-3_amd64.deb
dpkg --fsys-tarfile libgphoto2-port12_2.5.10-3_amd64.deb | tar xf -
sudo mv ./usr/lib/x86_64-linux-gnu/libgphoto2_port.so.12.0.0 /opt/nautilus-gopro/lib/libgphoto2_port.so.12
sudo mv ./usr/lib/x86_64-linux-gnu/libgphoto2_port /opt/nautilus-gopro/lib
sudo ln -s /opt/nautilus-gopro/lib/libgphoto2_port/0.12.0 /usr/lib/x86_64-linux-gnu/libgphoto2_port/0.12.0
rm -r ./usr

# install updated libgphoto2
wget http://fr.archive.ubuntu.com/ubuntu/pool/main/libg/libgphoto2/libgphoto2-6_2.5.10-3_amd64.deb
dpkg --fsys-tarfile libgphoto2-6_2.5.10-3_amd64.deb | tar xf -
sudo mv ./usr/lib/x86_64-linux-gnu/libgphoto2.so.6.0.0 /opt/nautilus-gopro/lib/libgphoto2.so.6
sudo mv ./usr/lib/x86_64-linux-gnu/libgphoto2 /opt/nautilus-gopro/lib
sudo ln -s /opt/nautilus-gopro/lib/libgphoto2/2.5.10 /usr/lib/x86_64-linux-gnu/libgphoto2/2.5.10
rm -r ./usr ./lib

# download nautilus launcher
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/nautilus-newfile-declare https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/nautilus-newfile-declare
sudo chmod +x /opt/nautilus-gopro/nautilus



