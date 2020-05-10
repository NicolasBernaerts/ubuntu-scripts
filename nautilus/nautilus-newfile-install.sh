#!/usr/bin/env bash
# Creation of empty documents from Nautilus

# get template directory
TEMPLATE_DIR=$(grep XDG_TEMPLATES_DIR ~/.config/user-dirs.dirs | cut -d'=' -f2 | tr -d "\"")

# retrieve models
if [ "${TEMPLATE_DIR}" != "" ]
then
  mkdir --parents "${TEMPLATE_DIR}"
  wget -O "${TEMPLATE_DIR}/Calc Sheet.ods" https://github.com/NicolasBernaerts/ubuntu-scripts/blob/master/nautilus/nautilus-newfile/Calc%20Sheet.ods?raw=true
  wget -O "${TEMPLATE_DIR}/Writer Document.odt" https://github.com/NicolasBernaerts/ubuntu-scripts/blob/master/nautilus/nautilus-newfile/Writer%20Document.odt?raw=true
  wget -O "${TEMPLATE_DIR}/Bash Script.sh" https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/nautilus-newfile/Bash%20Script.sh
  wget -O "${TEMPLATE_DIR}/Text File.txt" https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/nautilus-newfile/Text%20File.txt
fi
