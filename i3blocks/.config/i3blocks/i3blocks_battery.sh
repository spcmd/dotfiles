#!/bin/sh

capacity=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

if [ "$status" != "Charging" ] && [ "$capacity" -le 30 ] && [ "$capacity" -gt 20 ]; then

	bat_widget="<span foreground='#C21E00'> $capacity%</span>"

elif [ "$status" != "Charging" ] && [ "$capacity" -le 20 ]; then

       bat_widget="<span foreground='#de0404'> $capacity%</span>"

elif [ "$status" = "Charging" ] || [ "$status" = "Full" ]; then

	bat_widget="  $capacity%"

else
        bat_widget=" $capacity%"
fi

echo "${bat_widget}"