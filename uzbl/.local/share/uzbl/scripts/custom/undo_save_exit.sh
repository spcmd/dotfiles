#!/bin/sh

UNDO="/tmp/uzbl_undolist"

if [ -e "$UNDO" ]; then
    LINECOUNT=$(cat $UNDO | wc -l)
    if [ "$LINECOUNT" -ge 100 ]; then
        sed -i "1d" "$UNDO"
    fi
fi
echo "$UZBL_URI" >> "$UNDO"
