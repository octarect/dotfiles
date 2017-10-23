#!/bin/sh
# accelerate speed of pointing
xinput --set-prop pointer:"SINO WEALTH Gaming Keyboard" "libinput Accel Speed" 1  
# Emulate scroll wheel in built in nub while holding the right click button  
xinput --set-prop pointer:"SINO WEALTH Gaming Keyboard" "libinput Middle Emulation Enabled" 1  
# Trigger wheel emulation with button 3 (right click)  
xinput --set-prop pointer:"SINO WEALTH Gaming Keyboard" "libinput Button Scrolling Button" 3
