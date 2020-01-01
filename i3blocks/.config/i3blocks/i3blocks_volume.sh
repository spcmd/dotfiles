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
            level="<span foreground='#de0404'>MUTE</span>"
        else
            level=$level
        fi
        pkill -RTMIN+1 i3blocks
        ;;
    max)
        amixer sset Master 100; pkill -RTMIN+1 i3blocks
        ;;
    lvl20)
        # this is level 20
        amixer sset Master 41; pkill -RTMIN+1 i3blocks
        ;;
    lvl40)
        # this is level 40
        amixer sset Master 59; pkill -RTMIN+1 i3blocks
        ;;
esac

# i3blocks volume status
level=$(amixer -M get Master | awk '/%/{gsub( /[][%]/,"" );print $(NF-2)}')
state=$(amixer -M get Master | awk '/\[on|off\]/{gsub("[\\[\\]]","");print $NF}')
if [ "$state" = "off" ]; then
    level="<span foreground='#de0404'>MUTE</span>"
else
    level=$level
fi
echo "$level"

# mouse button clicks
case $BLOCK_BUTTON in
    1) i3-msg exec "$HOME/.config/i3blocks/i3blocks_volume.sh toggle" ;;
    2) i3-msg exec "urxvtc -name alsamixer -e alsamixer" ;;
    3) i3-msg exec "$HOME/.config/i3blocks/i3blocks_volume.sh max" ;;
    4) i3-msg exec "$HOME/.config/i3blocks/i3blocks_volume.sh down" ;;
    5) i3-msg exec "$HOME/.config/i3blocks/i3blocks_volume.sh up" ;;
esac
