#!/usr/bin/env dash

# manage external monitor
#
# put these in bspwrc to automatically remove unplugged/disabled monitors
# and move their desktops to the first monitor (laptop display):
#   bspc config remove_disabled_monitors true
#   bspc config remove_unplugged_monitors true

# names are listed by `xrandr` or `bspc query -M`
external="HDMI1"

if [ ! -z "$(xrandr | grep -w "$external connected")" ]; then
    case $1 in
        off)
            xrandr --output $external --off
            ;;
        extended|on)
            xrandr --output HDMI1 --auto --right-of eDP1 && ~/.fehbg
            ;;
        -h|--help|help|"")
            echo "Usage: $0 [option]"
            echo "Options:"
            echo "          off                 Turn off external monitor ($external) and remove it from bspwm."
            echo "          on, extended        Turn on external monitor ($external) as extended."
            echo "          help, -h, --help    This help."
    esac
else
    echo "No $external detected. Check xrandr!"
    notify-send "No $external detected. Check xrandr!"
fi
