#!/bin/sh
case $1/$2 in
  pre/*)
    echo "Going to $2..."
    ;;
  post/*)
    echo "Waking up from $2..."
    hdparm -B255 /dev/sda
    echo "hdparm set to B255 on /dev/sda"
    ;;
esac
