#!/bin/sh
# install tool to scan envelopes and OCR addresses
sudo wget -O /usr/local/bin/envelope2address https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/scanner/envelope2address
sudo chmod +x /usr/local/bin/envelope2address
sudo wget -O /usr/share/applications/envelope2address.desktop https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/scanner/envelope2address.desktop
sudo chmod +x /usr/share/applications/envelope2address.desktop
