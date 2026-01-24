#!/usr/bin/env bash
# Declaration of empty document models for Nautilus
# Tested on Ubuntu 18.04, 20.04 and 22.04 LTS

# get templates user path
DIR_TEMPLATE=$(xdg-user-dir TEMPLATES)

# download and install empty documents templates
if [ -d "${DIR_TEMPLATE}" ]
then
  # download templates
  wget -O "${DIR_TEMPLATE}/Calc Sheet.ods" https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/refs/heads/master/nautilus/template/Calc%20Sheet.ods
  wget -O "${DIR_TEMPLATE}/Writer Document.odt" https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/refs/heads/master/nautilus/template/Writer%20Document.odt
  wget -O "${DIR_TEMPLATE}/Bash Script.sh" https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/refs/heads/master/nautilus/template/Bash%20Script.sh
  wget -O "${DIR_TEMPLATE}/Text File.txt" https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/refs/heads/master/nautilus/template/Text%20File.txt

  # set execute attributes
  chmod +x "${DIR_TEMPLATE}/Bash Script.sh"
fi
