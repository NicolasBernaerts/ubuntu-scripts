#!/bin/bash
# Dump latest display environment and D-Bus address to /tmp/.desktop-session.last
#
# This file is generated to be used by system daemon to send desktop notifications

# desktop session data file
DESKTOP_SESSION="/tmp/.desktop-session.last"

# DBus address
echo "DESKTOP_DBUS=${DBUS_SESSION_BUS_ADDRESS}" > "${DESKTOP_SESSION}"

# display address
echo "DESKTOP_DISPLAY=${DISPLAY}" >> "${DESKTOP_SESSION}"

# user
echo "DESKTOP_USER=${USER}" >> "${DESKTOP_SESSION}"
