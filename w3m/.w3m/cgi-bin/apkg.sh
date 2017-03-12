#!/bin/bash
#                               _
#  ___ _ __   ___ _ __ ___   __| |
# / __| '_ \ / __| '_ ` _ \ / _` |
# \__ | |_) | (__| | | | | | (_| |
# |___| .__/ \___|_| |_| |_|\__,_|
#     |_|
# Created by: spcmd
# http://spcmd.github.io
# https://github.com/spcmd

# Arch Linux package search for w3m

# 0. In ~/.w3m/config set this option: cgi_bin ~/.w3m/cgi-bin
# 1. Put this script to ~/.w3m/cgi-bin
# 2. Put the line(s) below to ~/.w3m/urimethodmap
#    apkg: file:/cgi-bin/apkg.sh?%s

# USAGE:
#    In w3m, for URL type apkg:keyword
#    for multiple keywords, use the plus sign: apkg:keyword1+keyword2

url="https://www.archlinux.org/packages/?q="
query=$(echo "$QUERY_STRING" | sed 's/apkg://')

link="${url}${query}"

cat <<EOF
w3m-control: GOTO $link
w3m-control: DELETE_PREVBUF
w3m-control: SEARCH Keywords
w3m-control: NEXT_LINK
EOF
