#!/bin/sh

# i3wm
pacman -S i3wm

# Network
pacman -S networkmanager network-manager-applet

# Audio
pacman -S pulseaudio pulseaudio-bluetooth pulseaudio-equalizer pavucontrol
yay -S pasystray-git

# Input Manager
pacman -S fcitx-im fcitx-mozc fcitx-configtool
# [Optional] japanese fonts
pacman -S otf-ipafont ttf-dejavu

# Screen brightness
# Up:   light -A 10
# Down: light -U 10
# Set minimum brightness: light -N 10
pacman -S light

# F**k PowerButton
nvim /etc/systemd/logind.conf
# - - -
# HandlePowerKey=ignore
# HandleLidSwitch=ignore
# - - -

# Touchpad (only Chromebook??)
pacman -S synaptics
nvim /etc/X11/xorg.conf.d/50-c720-touchpad.conf
# - - -
# Section "InputClass"
#     Identifier      "touchpad peppy cyapa"
#     MatchIsTouchpad "on"
#     MatchDevicePath "/dev/input/event*"
#     MatchProduct    "cyapa"

#     Option          "TapButton1" "1"
#     Option          "TapButton2" "3"
#     Option          "TapButton3" "2"

#     Option          "FingerLow" "8"
#     Option          "FingerHigh" "16"
#     Option          "FingerPress" "256"

#     Option          "VertEdgeScroll" "0"
#     Option          "VertTwoFingerScroll" "1"
#     Option          "HorizTwoFingerScroll" "1"
#     Option          "AreaRightEdge" "850"
#     Option          "AreaLeftEdge" "50"
# EndSection
# - - -
