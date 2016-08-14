#!/usr/bin/env bash
# Creation of empty documents from Nautilus

# test Nautilus
command -v nautilus >/dev/null 2>&1 || { echo "Nautilus has not been detected. Please install it first."; exit 1; }

# install nautilus-actions
sudo apt-get update
sudo apt-get -y install nautilus-actions

# nautilus : remove nautilus action root menu
mv $HOME/.config/nautilus-actions/nautilus-actions.conf $HOME/.config/nautilus-actions/nautilus-actions.conf.org
cat $HOME/.config/nautilus-actions/nautilus-actions.conf.org | sed 's/items-create-root-menu=.*/items-create-root-menu=false/' > $HOME/.config/nautilus-actions/nautilus-actions.conf

# install functions to read INI files
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/read-ini-file https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/tools/read-ini-file
sudo chmod +x /usr/local/bin/read-ini-file

# install newfile scripts
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/nautilus-newfile-declare https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/nautilus-newfile-declare
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/nautilus-newfile-action https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/nautilus-newfile-action
sudo chmod +x /usr/local/bin/nautilus-newfile-declare
sudo chmod +x /usr/local/bin/nautilus-newfile-action

# install .ini configuration file
wget --header='Accept-Encoding:none' -O "$HOME/.config/nautilus-actions/newfile.ini" https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/newfile/newfile.ini

# install empty docuemnt models
mkdir --parents $HOME/.config/nautilus-actions/newfile
wget --header='Accept-Encoding:none' -O "$HOME/.config/nautilus-actions/newfile/New Calc Sheet.ods" https://github.com/NicolasBernaerts/ubuntu-scripts/blob/master/nautilus/newfile/New%20Calc%20Sheet.ods?raw=true
wget --header='Accept-Encoding:none' -O "$HOME/.config/nautilus-actions/newfile/New Writer Document.odt" https://github.com/NicolasBernaerts/ubuntu-scripts/blob/master/nautilus/newfile/New%20Writer%20Document.odt?raw=true
wget --header='Accept-Encoding:none' -O "$HOME/.config/nautilus-actions/newfile/New Bash Script.sh" https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/newfile/New%20Bash%20Script.sh
wget --header='Accept-Encoding:none' -O "$HOME/.config/nautilus-actions/newfile/New File.txt" https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/newfile/New%20File.txt

# declare new empty files
/usr/local/bin/nautilus-newfile-declare --install
