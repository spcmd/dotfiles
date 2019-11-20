#!/bin/bash

SONGTITLE=$(mocp -i | grep 'SongTitle:' | sed -e 's/^.*: //');
ARTIST=$(mocp -i | grep 'Artist:' | sed -e 's/^.*: //');
ALBUM=$(mocp -i | grep 'Album:' | sed -e 's/^.*: //');
FILENAME=$(mocp -i | grep "File" | sed 's/File: //' | sed 's/.*\///')

if [[ ! -z $ARTIST ]]; then
    #echo "   $ARTIST - $SONGTITLE  <span foreground='#4e4e4e'>($ALBUM)</span> "; pkill -RTMIN+3 i3blocks
    echo "  $ARTIST - $SONGTITLE"; pkill -RTMIN+3 i3blocks
elif [[ ! -z $FILENAME ]]; then
    echo "  $FILENAME"; pkill -RTMIN+3 i3blocks
else
    pkill -RTMIN+3 i3blocks
fi
