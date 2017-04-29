#!/bin/sh
# QtADB installation

# installation of packages
sudo apt-get -y install libqtgui4 libqt4-network libqt4-declarative

# download of main program
wget --header='Accept-Encoding:none' http://motyczko.pl/qtadb/QtADB_0.8.1_linux64.tar.gz
tar -xvf QtADB_0.8.1_linux64.tar.gz
sudo mv ./QtADB*/QtADB /usr/local/sbin/qtadb
sudo chmod +x /usr/local/sbin/qtadb

# download desktop launcher
sudo wget --header='Accept-Encoding:none' -O /usr/share/icons/qtadb.png https://github.com/NicolasBernaerts/ubuntu-scripts/raw/master/android/qtadb.png
sudo wget --header='Accept-Encoding:none' -O /usr/share/applications/qtadb.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/android/qtadb.desktop

# configuration file to get rid of launch crash
mkdir -p $HOME/.config/Bracia
wget --header='Accept-Encoding:none' -O $HOME/.config/Bracia/QtADB.conf https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/android/QtADB.conf

# cleanup
rm QtADB_0.8.1_linux64.tar.gz
rm -R QtADB*
