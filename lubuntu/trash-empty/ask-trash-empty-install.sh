#!/bin/sh
# Declare right click "empty trash" on desktop trash

# test Ubuntu distribution
DISTRO=$(lsb_release -is 2>/dev/null)
[ "${DISTRO}" != "Ubuntu" ] && { zenity --error --text="This automatic installation script is for Ubuntu only"; exit 1; }

# install tools
sudo apt-get -y install trash-cli

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/ask-trash-empty https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/lubuntu/trash-empty/ask-trash-empty
sudo chmod +x /usr/local/bin/ask-trash-empty

# desktop integration
mkdir --parents $HOME/.local/share/file-manager/actions
wget --header='Accept-Encoding:none' -O $HOME/.local/share/file-manager/actions/ask-trash-empty.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/lubuntu/trash-empty/ask-trash-empty.desktop
