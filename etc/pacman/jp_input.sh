#!/bin/sh

# There is mozc package in AUR. It make a good candidates but its installation is often failed. (at 20190414)
# So using libkkc instead of it is better I think.

sudo pacman -S ibus-kkc ibus-qt
