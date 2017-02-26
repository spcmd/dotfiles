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

# convert currency from
if [[ "$1" = "USD-HUF" ]]; then
    from="USD"
elif [[ "$1" = "GBP-HUF" ]]; then
    from="GBP"
elif [[ "$1" = "EUR-HUF" ]]; then
    from="EUR"
else
    exit 1
fi

# convert currency to
to=HUF

# how many
amount=${QUTE_SELECTED_TEXT}

# convert
converted=$(wget -qO- "http://www.google.com/finance/converter?a=$amount&from=$from&to=$to" | sed '/res/!d;s/<[^>]*>//g')

# push to qutebrowser in a message
echo "message-info \"$converted\"" >> "$QUTE_FIFO"
