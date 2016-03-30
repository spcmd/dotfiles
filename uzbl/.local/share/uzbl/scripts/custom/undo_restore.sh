#!/bin/sh

UNDO="/tmp/uzbl_undolist"

if [ -e "$UNDO" ]; then
    URL=$(tail -n 1 "$UNDO")
    LINECOUNT=$(cat "$UNDO" | wc -l)
    if [ "$LINECOUNT" == 1 ]; then
        rm "$UNDO"
    else
        sed -i '$d' "$UNDO"
    fi
  #echo "event NEW_TAB $URL" > "$UZBL_FIFO" 
  echo "event NEW_TAB $URL" | socat - unix-connect:$UZBL_SOCKET
fi

