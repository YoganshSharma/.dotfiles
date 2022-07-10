#! /bin/sh
lxpolkit &
nitrogen --restore &
#blueman-applet & #or bluebery_tray
picom --experimental-backends -b &
nm-applet &
dunst &
disown &
