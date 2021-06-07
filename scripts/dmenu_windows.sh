#!/bin/zsh

# Import the colors
. "${HOME}/.cache/wal/colors.sh"

# Date format, for use as the prompt.
date=$(date +"%a %d. %b %R")

# dmenu cannot display more than 30 lines, to avoid screen clutter. Only relevant if you have more than 30 windows open.
height=$(wmctrl -l | wc -l)
if [[ $height -gt 30 ]]
	then heightfit=30
	else heightfit=$height
fi

num=$(wmctrl -l | sed 's/  / /' | cut -d " " -f 4- | nl -w 3 -n rn | sed -r 's/^([ 0-9]+)[ \t]*(.*)$/\1 - \2/' | dmenu -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15" -fn 'Hack Nerd Font:pixelsize=14:antialias=true:autohint=true' -i -p "$date" -l $heightfit -g 0 -l 1000 | cut -d '-' -f -1)
[[ -z "$num" ]] && exit
wmctrl -l | sed -n "$num p" | cut -c -10 | xargs wmctrl -i -a
