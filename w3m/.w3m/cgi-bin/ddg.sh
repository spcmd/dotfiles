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

# Duckduckgo search for w3m

# 0. In ~/.w3m/config set this option: cgi_bin ~/.w3m/cgi-bin
# 1. Put this script to ~/.w3m/cgi-bin
# 2. Put the line(s) below to ~/.w3m/urimethodmap
#    d: file:/cgi-bin/ddg.sh?%s
#    ddg: file:/cgi-bin/ddg.sh?%s

# USAGE:
#    In w3m, for URL type ddg:keyword OR d:keyword
#    for multiple keywords, use the plus sign: ddg:keyword1+keyword2 OR d:keyword1+keyword2

url="https://duckduckgo.com/?q="
query=$(echo "$QUERY_STRING" | sed -e 's/d://;s/ddg://')

link="${url}${query}"

cat <<EOF
w3m-control: GOTO $link
w3m-control: DELETE_PREVBUF
w3m-control: SEARCH \\[
w3m-control: MOVE_RIGHT
EOF
