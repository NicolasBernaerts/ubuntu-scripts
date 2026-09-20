#!/usr/bin/env bash
# Install service to handle AppArmor bugs

# tool
sudo wget -4 -O "/usr/local/bin/apparmor-bug" https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/nautilus/apparmor-bug
sudo chmod +x /usr/local/bin/apparmor-bug

# service
sudo wget -4 -O "/etc/systemd/system/apparmor-bug.service" https://github.com/NicolasBernaerts/ubuntu-scripts/raw/refs/heads/master/nautilus/apparmor-bug.service
sudo chmod 644 /etc/systemd/system/pparmor-bug.service
sudo systemctl enable apparmor-bug.service
sudo systemctl start apparmor-bug.service
