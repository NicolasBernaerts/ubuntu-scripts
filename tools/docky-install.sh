#!/bin/bash
# -------------------------------------------------------
# Script to install Docky desktop launcher
# -------------------------------------------------------

# sweethome3d
sudo apt-get -y install docky

# remove docky anchor
gconftool-2 --type Boolean --set /apps/docky-2/Docky/Items/DockyItem/ShowDockyItem false
