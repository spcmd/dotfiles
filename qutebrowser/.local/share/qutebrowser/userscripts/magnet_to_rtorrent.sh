#!/bin/sh
#                               _
#  ___ _ __   ___ _ __ ___   __| |
# / __| '_ \ / __| '_ ` _ \ / _` |
# \__ | |_) | (__| | | | | | (_| |
# |___| .__/ \___|_| |_| |_|\__,_|
#     |_|
# Created by: spcmd
# http://spcmd.github.io
# https://github.com/spcmd

# Quickly load torrent magnet links to rtorrent

name="rTorrent"
search=$(xdotool search --classname $name)

echo "${QUTE_URL}" | xsel -b && \
if [ ! -z "$search" ]; then
    xdotool windowactivate "$search" && \
    xdotool key Return && \
    xdotool key Ctrl+Shift+v
else
    notify-send "$(basename "$0")" "Error: No such window: $name. Is rTorrent running?"
    exit 1
fi
