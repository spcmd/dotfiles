#!/bin/bash

# Show calendar in a little urxvtc window (run the 'cal' command)

# Get the id of the window named 'cal'
id=$(xdo id -n cal)

# If an id exists, we have the calendar opened, so close it
if [[ $id ]]; then
    xdo close -n cal
# else open the calendar
else
    urxvtc -hold -geometry 22x10 -cr black -name cal -e cal -m
fi
