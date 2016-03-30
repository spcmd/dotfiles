#!/bin/sh

count_tabs=$(pgrep -c uzbl-core)

if [ "$count_tabs" -gt 1 ]; then
    #echo "exit" | socat - unix-connect:$UZBL_SOCKET && notify-send "TAB count: $count_tabs"
    #echo "exit" > "$UZBL_FIFO" && notify-send "TAB count: $count_tabs"
    echo "exit" > "$UZBL_FIFO"
else
    #echo "uri file://@config_home/newtab.html" | socat - unix-connect:$UZBL_SOCKET && notify-send "TAB count: $count_tabs"
    #echo "uri file://@config_home/newtab.html" > "$UZBL_FIFO" && notify-send "TAB count: $count_tabs"
    echo "uri file://@config_home/newtab.html" > "$UZBL_FIFO"
fi
