#!/bin/bash
# Dump latest display environment variables to /tmp/.latest-desktop-session.ini
# Variables are :
#  - USER
#  - DISPLAY
#  - DBUS_SESSION_BUS_ADDRESS

# desktop session data file
DESKTOP_SESSION=/tmp/.latest-desktop-session.ini

# Write current session data
echo "[desktop-session]" > "${DESKTOP_SESSION}"
echo "User=${USER}" >> "${DESKTOP_SESSION}"
echo "Display=${DISPLAY}" >> "${DESKTOP_SESSION}"
echo "DBus=${DBUS_SESSION_BUS_ADDRESS}" >> "${DESKTOP_SESSION}"
