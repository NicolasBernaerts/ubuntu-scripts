#!/usr/bin/env bash
# Install apk tags extensions for Nautilus

# test Nautilus
command -v nautilus >/dev/null 2>&1 || { echo "Nautilus has not been detected. Please install it first."; exit 1; }

# install python extension management for nautilus
sudo apt -y install python-nautilus

# install aapt
sudo apt -y install aapt

# if needed, create extensions directory
mkdir --parents "$HOME/.local/share/nautilus-python/extensions"

# install nautilus extensions
wget -O "$HOME/.local/share/nautilus-python/extensions/apk-columns.py" https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/extensions/apk-columns.py
wget -O "$HOME/.local/share/nautilus-python/extensions/apk-properties.py" https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/extensions/apk-properties.py

# close nautilus to force extension reload
nautilus -q
