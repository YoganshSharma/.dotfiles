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
python /opt/youtube-local/server.py
conky -c ~/.config/conky/system
conky -c ~/.config/conky/arch-rss
# conky -c ~/.config/conky/todo
picom 
disown
xrdb -load ~/.config/x11/xresources
wmname LG3D # so that android studio and other java gui works properly https://wiki.archlinux.org/title/Java#Impersonate_another_window_manager
# xscreensaver &
