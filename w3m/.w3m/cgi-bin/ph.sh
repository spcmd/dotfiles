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

# Prohardver.hu search for w3m

# 0. In ~/.w3m/config set this option: cgi_bin ~/.w3m/cgi-bin
# 1. Put this script to ~/.w3m/cgi-bin
# 2. Put the line(s) below to ~/.w3m/urimethodmap
#    ph: file:/cgi-bin/ph.sh?%s

# USAGE:
#    In w3m, for URL type ph:keyword
#    for multiple keywords, use the plus sign: ph:keyword1+keyword2

domain="logout"
url="https://${domain}.hu/temak/keres.php?stext="
fallback_url="https://${domain}.hu/forum/index.html"
query=$(echo "$QUERY_STRING" | sed 's/ph://')

link="${url}${query}"

if [[ $query ]]; then
cat <<EOF
w3m-control: GOTO $link
w3m-control: DELETE_PREVBUF
w3m-control: SEARCH Fórumtémák
w3m-control: SEARCH_NEXT
w3m-control: MOVE_RIGHT
EOF
else
cat <<EOF
w3m-control: GOTO $fallback_url
w3m-control: DELETE_PREVBUF
w3m-control: SEARCH \\[
w3m-control: MOVE_RIGHT
EOF
fi
