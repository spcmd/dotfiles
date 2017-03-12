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

# Youtube search for w3m

# 0. In ~/.w3m/config set this option: cgi_bin ~/.w3m/cgi-bin
# 1. Put this script to ~/.w3m/cgi-bin
# 2. Put the line(s) below to ~/.w3m/urimethodmap
#    yt: file:/cgi-bin/yt.sh?%s

# USAGE:
#    In w3m, for URL type yt:keyword
#    for multiple keywords, use the plus sign: yt:keyword1+keyword2

url="https://www.youtube.com/results?search_query="
query=$(echo "$QUERY_STRING" | sed 's/yt://')

link="${url}${query}"

if [[ $query ]]; then
cat <<EOF
w3m-control: GOTO $link
w3m-control: DELETE_PREVBUF
w3m-control: SEARCH Sort by
w3m-control: SEARCH 2\.
EOF
else
cat <<EOF
w3m-control: GOTO $link
w3m-control: DELETE_PREVBUF
w3m-control: SEARCH \\[
w3m-control: MOVE_RIGHT
EOF
fi
