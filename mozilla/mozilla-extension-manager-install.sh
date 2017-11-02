#!/bin/sh
# Mozilla Firefox & Thunderbird commandline extension

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/mozilla-extension-manager https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/mozilla/mozilla-extension-manager
sudo chmod +x /usr/local/bin/mozilla-extension-manager

# --------------------------------------
#  install firefox extensions
# --------------------------------------

# AdBlockPlus
mozilla-extension-manager --user --install https://addons.mozilla.org/firefox/downloads/latest/1865/addon-1865-latest.xpi

# FlashDisable
mozilla-extension-manager --user --install https://addons.mozilla.org/firefox/downloads/latest/383235/addon-383235-latest.xpi

# Print Friendly and PDF
mozilla-extension-manager --user --install https://addons.mozilla.org/firefox/downloads/latest/print-friendly-pdf/platform:5/addon-465349-latest.xpi

# Video DownloadHelper
mozilla-extension-manager --user --install https://addons.mozilla.org/firefox/downloads/latest/video-downloadhelper/addon-3006-latest.xpi
