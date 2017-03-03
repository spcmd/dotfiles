#!/bin/sh

# volume change (bind these to keys)
case $1 in
    up)
        amixer sset Master 2%+; pkill -RTMIN+1 i3blocks
        ;;
    down)
        amixer sset Master 2%-; pkill -RTMIN+1 i3blocks
        ;;
    toggle)
        amixer sset Master toggle
        level=$(amixer -M get Master | awk '/%/{gsub( /[][%]/,"" );print $(NF-2)}')
        state=$(amixer -M get Master | awk '/\[on|off\]/{gsub("[\\[\\]]","");print $NF}')
        if [ "$state" = "off" ]; then
            level="<span foreground='red'>OFF</span>"
        else
            level=$level
        fi
        ;;
    max)
        amixer sset Master 100; pkill -RTMIN+1 i3blocks
esac

# i3blocks volume status
level=$(amixer -M get Master | awk '/%/{gsub( /[][%]/,"" );print $(NF-2)}')
state=$(amixer -M get Master | awk '/\[on|off\]/{gsub("[\\[\\]]","");print $NF}')
if [ "$state" = "off" ]; then
    level="<span foreground='red'>OFF</span>"
else
    level=$level
fi
echo "$level" ; pkill -RTMIN+1 i3blocks
