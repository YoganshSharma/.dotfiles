nitrogen --restore &
killall dwmblocks 
dwmblocks &
# picom &
dunst &
lxpolkit &
# fcitx5 -d &
pgrep xidlehook || xidlehook --not-when-audio --not-when-fullscreen --timer 1800 '/usr/local/bin/slock systemctl hybrid-sleep' ''&
# pgrep redshift-gtk || (redshift -x; redshift-gtk) &
pgrep xbanish || xbanish &
pgrep timelapse || timelapse &
pgrep deluged || deluged &
disown
xmodmap  ~/.config/x11/xmodmap
xrdb -load ~/.config/x11/xresources
# xscreensaver &
