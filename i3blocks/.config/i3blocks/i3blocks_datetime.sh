#!/bin/sh

date +'%a %b %d, %H:%M'

case $BLOCK_BUTTON in
    1) i3-msg exec "urxvtc -hold -e cal -m" ;; # current month
    2) i3-msg exec "urxvtc -hold -e sh -c 'cal -m -3 | cut -c 1-20'" ;; # previous month
    3) i3-msg exec "urxvtc -hold -e sh -c 'cal -m -3 | cut -c 45-64'" ;; # next month
esac
