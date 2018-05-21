#!/bin/sh

capacity=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

if [ "$status" != "Charging" ] && [ "$capacity" -le 30 ] && [ "$capacity" -gt 20 ]; then
        widget_cap="$capacity"
elif [ "$status" != "Charging" ] && [ "$capacity" -le 20 ]; then
        widget_cap="$capacity"
else
        widget_cap=$capacity
fi

if [ "$status" = "Charging" ]; then
        widget_status="Charging"
else
        widget_status="Bat"
fi

echo "${widget_status}: ${widget_cap}%"


