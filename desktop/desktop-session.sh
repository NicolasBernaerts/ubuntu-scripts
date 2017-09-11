#!/bin/bash
# Dump latest display environment and D-Bus address to /var/run/desktop-session.last
#
# This file is generated to be used by system daemon to send desktop notifications

# desktop session data file
DESKTOP_SESSION=/tmp/.desktop-session.ini

# Write current session data
echo "[desktop-session]" > "${DESKTOP_SESSION}"
echo "User=${USER}" >> "${DESKTOP_SESSION}"
echo "Display=${DISPLAY}" >> "${DESKTOP_SESSION}"
echo "DBus=${DBUS_SESSION_BUS_ADDRESS}" >> "${DESKTOP_SESSION}"
