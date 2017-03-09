#!/usr/bin/env bash
# Install specific version of melt embedding vid.stab filter

# test Ubuntu or Linux Minty distribution
DISTRO=$(lsb_release -sc 2>/dev/null)
[ "${DISTRO}" != "sarah" ] && [ "${DISTRO}" != "xenial" ] && { zenity --error --text="This automatic installation script is for Ubuntu Xenial or Linux Mint Sarah only"; exit 1; }

# create /opt/mlt-vidstab directory structure
sudo mkdir --parent /opt/vidstab

# extract file from melt
wget https://launchpad.net/~sunab/+archive/ubuntu/kdenlive-release/+build/9289708/+files/melt_6.0.0-0ubuntu0~sunab~xenial1_amd64.deb
dpkg --fsys-tarfile melt_6.0.0-0ubuntu0~sunab~xenial1_amd64.deb | sudo tar xf - -C /opt/vidstab
rm melt_6.0.0-0ubuntu0~sunab~xenial1_amd64.deb

# extract files from libmlt6
wget https://launchpad.net/~sunab/+archive/ubuntu/kdenlive-release/+build/9289708/+files/libmlt6_6.0.0-0ubuntu0~sunab~xenial1_amd64.deb
dpkg --fsys-tarfile libmlt6_6.0.0-0ubuntu0~sunab~xenial1_amd64.deb | sudo tar xf - -C /opt/vidstab
sudo ln -s /opt/vidstab/usr/lib/mlt /usr/lib/mlt
rm libmlt6_6.0.0-0ubuntu0~sunab~xenial1_amd64.deb

# extract file from libmlt++3
wget https://launchpad.net/~sunab/+archive/ubuntu/kdenlive-release/+build/9289708/+files/libmlt++3_6.0.0-0ubuntu0~sunab~xenial1_amd64.deb
dpkg --fsys-tarfile libmlt++3_6.0.0-0ubuntu0~sunab~xenial1_amd64.deb | sudo tar xf - -C /opt/vidstab
rm libmlt++3_6.0.0-0ubuntu0~sunab~xenial1_amd64.deb

# extract files from libmlt-data
wget https://launchpad.net/~sunab/+archive/ubuntu/kdenlive-release/+build/9289708/+files/libmlt-data_6.0.0-0ubuntu0~sunab~xenial1_all.deb
dpkg --fsys-tarfile libmlt-data_6.0.0-0ubuntu0~sunab~xenial1_all.deb | sudo tar xf - -C /opt/vidstab
sudo ln -s /opt/vidstab/usr/share/mlt/vid.stab /usr/share/mlt/vid.stab
rm libmlt-data_6.0.0-0ubuntu0~sunab~xenial1_all.deb

# extract file from libvidstab1.0
wget https://launchpad.net/~sunab/+archive/ubuntu/kdenlive-release/+files/libvidstab1.0_0.98b-0ubuntu0~sunab~xenial1_amd64.deb
dpkg --fsys-tarfile libvidstab1.0_0.98b-0ubuntu0~sunab~xenial1_amd64.deb | sudo tar xf - -C /opt/vidstab
rm libvidstab1.0_0.98b-0ubuntu0~sunab~xenial1_amd64.deb

# install melt wrapper
sudo wget --header='Accept-Encoding:none' -O /opt/vidstab/melt https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/video/melt-vidstab
sudo chmod +x /opt/vidstab/melt
