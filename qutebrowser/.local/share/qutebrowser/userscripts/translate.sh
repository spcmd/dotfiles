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


# Translate the selected text with my gdict script (which uses translate-shell)

text=${QUTE_SELECTED_TEXT}
translated=$(gdict $text)
echo "message-info \"$translated\"" >> "$QUTE_FIFO"
