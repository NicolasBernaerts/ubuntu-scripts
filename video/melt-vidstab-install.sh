#!/usr/bin/env bash
# Install specific version of melt embedding vid.stab filter

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# create /opt/mlt-vidstab directory structure
sudo mkdir --parent /opt/mlt-vidstab/bin /opt/mlt-vidstab/lib

# extract file from melt
wget https://launchpad.net/~sunab/+archive/ubuntu/kdenlive-release/+build/9289708/+files/melt_6.0.0-0ubuntu0~sunab~xenial1_amd64.deb
dpkg --fsys-tarfile melt_6.0.0-0ubuntu0~sunab~xenial1_amd64.deb | tar xOf - ./usr/bin/melt > melt
sudo mv melt /opt/mlt-vidstab/bin
sudo chmod +x /opt/mlt-vidstab/bin/melt

# extract files from libmlt6
wget https://launchpad.net/~sunab/+archive/ubuntu/kdenlive-release/+build/9289708/+files/libmlt6_6.0.0-0ubuntu0~sunab~xenial1_amd64.deb
dpkg --fsys-tarfile libmlt6_6.0.0-0ubuntu0~sunab~xenial1_amd64.deb | tar xf -
sudo mv ./usr/lib/libmlt.so.6.0.0 /opt/mlt-vidstab/lib/libmlt.so.6
sudo mv ./usr/lib/mlt /opt/mlt-vidstab/lib
sudo ln -s /opt/mlt-vidstab/lib/mlt /usr/lib/mlt
rm -r ./usr

# extract file from libmlt++3
wget https://launchpad.net/~sunab/+archive/ubuntu/kdenlive-release/+build/9289708/+files/libmlt++3_6.0.0-0ubuntu0~sunab~xenial1_amd64.deb
dpkg --fsys-tarfile libmlt++3_6.0.0-0ubuntu0~sunab~xenial1_amd64.deb | tar xOf - ./usr/lib/libmlt++.so.6.0.0 > libmlt++.so.3
sudo mv libmlt++.so.3 /opt/mlt-vidstab/lib

# extract files from libmlt-data
wget https://launchpad.net/~sunab/+archive/ubuntu/kdenlive-release/+build/9289708/+files/libmlt-data_6.0.0-0ubuntu0~sunab~xenial1_all.deb
dpkg --fsys-tarfile libmlt-data_6.0.0-0ubuntu0~sunab~xenial1_all.deb | tar xf -
sudo mv ./usr/share/mlt/vid.stab /opt/mlt-vidstab/lib
sudo ln -s /opt/mlt-vidstab/lib/vid.stab /usr/share/mlt/vid.stab
rm -r ./usr

# extract file from libvidstab1.0
wget https://launchpad.net/~sunab/+archive/ubuntu/kdenlive-release/+files/libvidstab1.0_0.98b-0ubuntu0~sunab~xenial1_amd64.deb
dpkg --fsys-tarfile libvidstab1.0_0.98b-0ubuntu0~sunab~xenial1_amd64.deb | tar xOf - ./usr/lib/libvidstab.so.1.0 > libvidstab.so.1.0
sudo mv libvidstab.so.1.0 /opt/mlt-vidstab/lib

# install melt wrapper
sudo wget --header='Accept-Encoding:none' -O /opt/mlt-vidstab/melt https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/melt-vidstab
sudo chmod +x /opt/mlt-vidstab/melt
