#!/bin/sh
 
# arandr generated output
xrandr --output LVDS1 --mode 1366x768 --pos 1920x312 --rotate normal --output VGA1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI1 --off --output VIRTUAL1 --off --output DP1 --off
 
# lxpanel reload
lxpanelctl restart
