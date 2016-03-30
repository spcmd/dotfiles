#!/bin/bash

# file with a list of domains (one domain per line)
# cookies from these domains will be kept
# example content:
#                   archlinux.org
#                   uzbl.org
#                   someotherdomain.com
#
domain_list=$HOME/.local/share/uzbl/keep-cookies-domains.txt

[[ ! -f $domain_list ]] && notify-send "$(basename $0) ERROR: can't find $domain_list" && exit 1

# convert list to a single line, seperate domains with \| 
keep=$(sed -e :a -e N -e 's/\n/\\|/' -e ta $domain_list)

# uzbl cookie files
cookie_file="$HOME/.local/share/uzbl/cookies.txt"
session_cookie_file="$HOME/.local/share/uzbl/session-cookies.txt"

# delete all cookies except the "keep list" 
[[ -f $cookie_file ]] && sed -i "/$keep/!d" $cookie_file
[[ -f $session_cookie_file ]] && sed -i "/$keep/!d" $session_cookie_file

#notify-send "uzbl" "cookies cleaned!"
