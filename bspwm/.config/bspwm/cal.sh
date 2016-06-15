#!/usr/bin/env dash

# Show calendar in a little urxvtc window (run the 'cal' command)

# Get the id of the window named 'cal'
id=$(xdo id -n cal)

# If an id exists, we have the calendar opened, so close it
if [ "$id" ]; then
    xdo close -n cal
# else open the calendar
else
    case "$1" in
        current) urxvtc -hold -geometry 22x10 -cr black -name cal -e cal -m ;;
        next) urxvtc -hold -geometry 22x10 -cr black -name cal -e sh -c "cal -m -3 | cut -c 45-64" ;;
        prev) urxvtc -hold -geometry 22x10 -cr black -name cal -e sh -c "cal -m -3 | cut -c 1-20" ;;
    esac
fi
