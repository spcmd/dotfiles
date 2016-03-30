#!/bin/bash

# Toggle javascript for a site: 
# URL: add to OR remove from whitelist

WHITELIST=$HOME/.local/share/uzbl/noscript-whitelist
 
domain=$(echo "$UZBL_URI" | awk -F/ '{sub("www.","");print $3}')
check_domain=$(grep "$domain" "$WHITELIST")

if [[ -z $check_domain ]]; then
    echo "$domain" >> $WHITELIST
    echo 'reload cached' > "$UZBL_FIFO"
else
    sed -i "\|$domain|d" "$WHITELIST"
    echo 'reload cached' > "$UZBL_FIFO"
fi
