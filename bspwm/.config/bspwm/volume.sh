#!/usr/bin/env dash

case $1 in
    up)
        amixer sset Master 2%+ ; echo "V$(amixer -M get Master | awk '/%/{gsub( /[][%]/,"" );print $(NF-2)}')" > "$PANEL_FIFO"
        ;;
    down)
        amixer sset Master 2%- ; echo "V$(amixer -M get Master | awk '/%/{gsub( /[][%]/,"" );print $(NF-2)}')" > "$PANEL_FIFO"
        ;;
    toggle)
        amixer sset Master toggle
        level=$(amixer -M get Master | awk '/%/{gsub( /[][%]/,"" );print $(NF-2)}')
        state=$(amixer -M get Master | awk '/\[on|off\]/{gsub("[\\[\\]]","");print $NF}')
        if [ "$state" = "off" ]; then
            level="%{F#ff3b3b}$level"
        else
            level=$level
        fi
        echo "V$level" > "$PANEL_FIFO"
        ;;
    max)
        amixer sset Master 100 ; echo "V$(amixer -M get Master | awk '/%/{gsub( /[][%]/,"" );print $(NF-2)}')" > "$PANEL_FIFO"
esac
