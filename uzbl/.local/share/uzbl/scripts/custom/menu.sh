#!/bin/bash

if [[ $1 = "current_tab" ]]; then
    DMENU_SCHEME="open_url"
else
    DMENU_SCHEME="open_url_newtab"
fi

DMENU_OPTIONS="xmms vertical resize"

. "$UZBL_UTIL_DIR/dmenu.sh"
. "$UZBL_UTIL_DIR/uzbl-dir.sh"

#[[ -r $UZBL_HISTORY_FILE ]] || exit 1
current="$(awk 'END {print $3}' "$UZBL_HISTORY_FILE")"

goto="$( (echo "> current page: $current"; awk '/http/{print $3}' "$UZBL_HISTORY_FILE" | sort -u) | $DMENU )"

open_in_current_tab() {
    if [[ $goto =~ ^(!d .+$) ]] || [[ $goto =~ ^(! .+$) ]]; then
        query=$(echo "$goto" | awk '{$1=""; print}')
        echo "uri https://duckduckgo.com/?q=$query" > "$UZBL_FIFO"
    elif [[ $goto =~ ^(!g .+$) ]]; then
        query=$(echo "$goto" | awk '{$1=""; print}')
        echo "uri https://google.com/search?q=$query" > "$UZBL_FIFO"
    else
        echo "uri $goto" > "$UZBL_FIFO"
    fi
}

open_in_new_tab() {
    if [[ $goto =~ ^(!d .+$) ]] || [[ $goto =~ ^(! .+$) ]]; then
        query=$(echo "$goto" | awk '{$1=""; print}')
        echo "event NEW_TAB 'https://duckduckgo.com/?q=$query'" > "$UZBL_FIFO"
    elif [[ $goto =~ ^(!g .+$) ]]; then
        query=$(echo "$goto" | awk '{$1=""; print}')
        echo "event NEW_TAB 'https://google.com/search?q=$query'" > "$UZBL_FIFO"
    else
        [[ ! -z $goto ]] && echo "event NEW_TAB $goto" > "$UZBL_FIFO"
    fi
}

case $1 in
    current_tab) open_in_current_tab;;
    new_tab) open_in_new_tab;;
esac
