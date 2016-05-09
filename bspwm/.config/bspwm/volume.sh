#!/bin/bash

case $1 in
    up)
        amixer sset Master 2%+ ; echo "V$(amixer -M get Master | awk '/%/{gsub( /[][%]/,"" );print $5}' | head -n1)" > "$PANEL_FIFO"
        ;;
    down)
        amixer sset Master 2%- ; echo "V$(amixer -M get Master | awk '/%/{gsub( /[][%]/,"" );print $5}' | head -n1)" > "$PANEL_FIFO"
        ;;
    toggle)
        amixer sset Master toggle
        level=$(amixer -M get Master | awk '/%/{gsub( /[][%]/,"" );print $5}' | head -n1)
        state=$(amixer -M get Master | awk '/\[on|off\]/{gsub("[\\[\\]]","");print $NF}' | head -n1)
        if [[ $state = "off" ]]; then
            level="%{F#ff3b3b}$level"
        else
            level=$level
        fi
        echo "V$level" > "$PANEL_FIFO"
        ;;
    max)
        amixer sset Master 100 ; echo "V$(amixer -M get Master | awk '/%/{gsub( /[][%]/,"" );print $5}' | head -n1)" > "$PANEL_FIFO"
esac
