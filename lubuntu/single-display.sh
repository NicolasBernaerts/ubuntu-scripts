#!/bin/sh
 
# arandr generated output
xrandr --output LVDS1 --mode 1366x768 --pos 0x0 --rotate normal --output VIRTUAL1 --off --output DP1 --off  --output HDMI1 --off --output VGA1 --off
 
# lxpanel reload
lxpanelctl restart
