#!/usr/bin/env dash

# manage external monitor

internal_name="eDP1"
external_name="HDMI1"

if [ ! -z "$(xrandr | grep -w $external_name)" ]; then
    case $1 in
        off)
            bspc wm -r $external_name && xrandr --output $external_name --off
            ;;
        extended|on)
            xrandr --output HDMI1 --auto --right-of eDP1 && ~/.fehbg
            ;;
        -h|--help|help|"")
            echo "Usage: $0 [option]"
            echo "Options:"
            echo "          off                 Turn off external monitor ($external_name) and remove it from bspwm."
            echo "          on, extended        Turn on external monitor ($external_name) as extended."
            echo "          help, -h, --help    This help."
    esac
else
    echo "No $external_name detected. Check xrandr!"
    notify-send "No $external_name detected. Check xrandr!"
fi
