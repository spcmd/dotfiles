#!/usr/bin/env dash

case $1 in
    hide|minimize)
        bspc node -g hidden
        echo "H[H]" > "$PANEL_FIFO"
        ;;
    unhide|unminimize)
        bspc node "$(bspc query -N -n .hidden | tail -n 1)" -g hidden=off
        if [ "$(bspc query -N -n .hidden | wc -l)" -eq 0 ]; then
            echo "H" > "$PANEL_FIFO"
        fi
        ;;
    query|list)
        list=$(bspc query -N -n .hidden)
        if [ "$list" ]; then
            notify-send "$(bspc query -N -n .hidden)"
        else
            notify-send "No hidden windows"
        fi
        ;;
esac

