#!/bin/sh

# clean cookies, remove everything except the allowed ones

file_keep_cookies_list=$HOME/.local/share/qutebrowser/keep_cookies_list
cookie_file=$HOME/.local/share/qutebrowser/cookies

keep_cookies_list=$(cat "$file_keep_cookies_list" | paste -sd "|")
sed -i -r "/${keep_cookies_list}/!d" $cookie_file 2>/dev/null

# send a message to qutebrowser
echo "message-info \"cookie cleaning: DONE!\"" >> "$QUTE_FIFO" 2>/dev/null
