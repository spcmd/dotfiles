#!/bin/sh

# this script runs in the background and calls another checker script periodically
# calling this from sway's config

while true; do
    $DIR_SCRIPTS/gmailcheck.sh
    sleep 5m
done
