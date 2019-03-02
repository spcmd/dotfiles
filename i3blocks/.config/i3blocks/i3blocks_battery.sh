#!/bin/sh

capacity=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

if [ "$status" != "Charging" ] && [ "$capacity" -le 30 ] && [ "$capacity" -gt 20 ]; then

	bat_widget="<span foreground='#D64C04'> $capacity%</span>"

elif [ "$status" != "Charging" ] && [ "$capacity" -le 20 ]; then

       bat_widget="<span foreground='#c21E00'> $capacity%</span>"

elif [ "$status" = "Charging" ] || [ "$status" = "Full" ]; then

	bat_widget="  $capacity%"

else
        bat_widget=" $capacity%"
fi

echo "${bat_widget}"
