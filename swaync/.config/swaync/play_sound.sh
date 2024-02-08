#!/bin/sh
if [ $(swaync-client -D) = "false" ]; then
	mpv --volume=50 ~/.config/dunst/notification.ogg &
fi
