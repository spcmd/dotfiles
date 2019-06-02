#!/bin/sh

#date +'%a %b %d, %H:%M'

# japanese format
date +'%-m月 %-d日、%a %H:%M' | sed 's/Mon/月/;s/Tue/火/;s/Wed/水/;s/Thu/木/;s/Fri/金/;s/Sat/土/;s/Sun/日/'

case $BLOCK_BUTTON in
    1) i3-msg exec "urxvtc -hold -e cal -m" ;; # current month
    2) i3-msg exec "urxvtc -hold -e sh -c 'cal -m -3 | cut -c 1-20'" ;; # previous month
    3) i3-msg exec "urxvtc -hold -e sh -c 'cal -m -3 | cut -c 45-64'" ;; # next month
esac
