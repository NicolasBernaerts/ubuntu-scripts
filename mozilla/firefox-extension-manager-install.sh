#!/bin/sh
# Mozilla Firefoxcommandline extension

# install main script
sudo wget --header='Accept-Encoding:none' -O /usr/local/bin/firefox-extension-manager https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/mozilla/firefox-extension-manager
sudo chmod +x /usr/local/bin/firefox-extension-manager

# --------------------------------------
#  install firefox extensions
# --------------------------------------

# AdBlock Plus
firefox-extension-manager --install --user --url https://addons.mozilla.org/fr/firefox/addon/adblock-plus/

# Disable HTML5 Autoplay 
firefox-extension-manager --install --user --url https://addons.mozilla.org/fr/firefox/addon/disable-autoplay/

# Print Friendly and PDF
firefox-extension-manager --install --user --url https://addons.mozilla.org/fr/firefox/addon/print-friendly-pdf/

# Video DownloadHelper
firefox-extension-manager --install --user --url https://addons.mozilla.org/fr/firefox/addon/video-downloadhelper/

# Empty cache button
firefox-extension-manager --install --user --url https://addons.mozilla.org/fr/firefox/addon/empty-cache-button/
