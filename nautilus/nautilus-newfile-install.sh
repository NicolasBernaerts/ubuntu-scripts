#!/usr/bin/env bash
# Creation of empty documents from Nautilus

# test Nautilus
command -v nautilus >/dev/null 2>&1 || { echo "Nautilus has not been detected. Please install it first."; exit 1; }

# install nautilus-actions
sudo apt-get update
sudo apt-get -y install nautilus-actions

# install functions to read INI files
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/read-ini-file https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tools/read-ini-file
sudo chmod +x /usr/local/bin/read-ini-file

# install newfile scripts
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/nautilus-newfile-declare https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/nautilus-newfile-declare
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/nautilus-newfile-action https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/nautilus-newfile-action
sudo chmod +x /usr/local/bin/nautilus-newfile-declare
sudo chmod +x /usr/local/bin/nautilus-newfile-action

# install .ini configuration file
wget --header='Accept-Encoding:none' -O "$HOME/.config/nautilus-actions/nautilus-newfile.ini" https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/nautilus-newfile.ini

# install empty document models
mkdir --parents $HOME/.config/nautilus-actions/nautilus-newfile
wget --header='Accept-Encoding:none' -O "$HOME/.config/nautilus-actions/nautilus-newfile/Calc Sheet.ods" https://github.com/NicolasBernaerts/ubuntu-scripts/blob/master/nautilus/nautilus-newfile-models/Calc%20Sheet.ods?raw=true
wget --header='Accept-Encoding:none' -O "$HOME/.config/nautilus-actions/nautilus-newfile/Writer Document.odt" https://github.com/NicolasBernaerts/ubuntu-scripts/blob/master/nautilus/nautilus-newfile-models/Writer%20Document.odt?raw=true
wget --header='Accept-Encoding:none' -O "$HOME/.config/nautilus-actions/nautilus-newfile/Bash Script.sh" https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/nautilus-newfile-models/Bash%20Script.sh
wget --header='Accept-Encoding:none' -O "$HOME/.config/nautilus-actions/nautilus-newfile/Text File.txt" https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/nautilus-newfile-models/Text%20File.txt

# declare new empty files
/usr/local/bin/nautilus-newfile-declare --install
