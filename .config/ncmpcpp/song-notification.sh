#!/bin/bash
ICON=~/.config/awesome/icons/mpv.png

dunstify -u low -i $ICON "<span font='16px'>Now Playing: $(mpc current)</span>"
