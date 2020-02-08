#!/bin/bash

# For usb type-c
# xrandr --output eDP1 --auto --scale 1x1 --rotate left --output DP1 --auto --scale 2.2x2.2 --right-of eDP1

# For microHDMI
xrandr --output eDP1 --auto --scale 1x1 --rotate left --output HDMI1 --auto --scale 2.2x2.2 --right-of eDP1
xinput map-to-output 15 eDP1
