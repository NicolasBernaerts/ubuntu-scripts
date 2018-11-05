#!/usr/bin/env bash
# Install image tags extensions for Nautilus

# test Nautilus
command -v nautilus >/dev/null 2>&1 || { echo "Nautilus has not been detected. Please install it first."; exit 1; }

# install python extension geopy.geocoders
python -m pip install geopy

# if needed, create extensions directory
mkdir --parents "$HOME/.local/share/nautilus-python/extensions"

# install nautilus extensions
wget -O "$HOME/.local/share/nautilus-python/extensions/exif-alltags.py" https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/extensions/exif-alltags.py
wget -O "$HOME/.local/share/nautilus-python/extensions/exif-geotag.py" https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/extensions/exif-geotag.py

# close nautilus to force extension reload
nautilus -q
