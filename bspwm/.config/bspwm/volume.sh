#!/bin/bash

case $1 in
    up)
        amixer sset Master 2%+ ; echo "V$(amixer -M get Master | awk '/%/{gsub( /[][%]/,"" );print $5}' | head -n1)" > "$PANEL_FIFO"
        ;;
    down)
        amixer sset Master 2%- ; echo "V$(amixer -M get Master | awk '/%/{gsub( /[][%]/,"" );print $5}' | head -n1)" > "$PANEL_FIFO"
        ;;
esac
