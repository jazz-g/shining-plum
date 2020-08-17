#!/bin/bash
ICON=$HOME/.xlock/icon.png
TMPBG=/tmp/$RANDOM.png
scrot $TMPBG
convert $TMPBG -filter Gaussian -blur 0x8 $TMPBG
convert $TMPBG $ICON -gravity center -composite -matte $TMPBG
i3lock -u --image=$TMPBG
