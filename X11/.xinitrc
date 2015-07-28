# Num lock ON
if [[ -e /usr/bin/numlockx ]]; then
    /usr/bin/numlockx &
fi

# Source Xmodmap
xmodmap ~/.Xmodmap &

# Set the wallpaper
sh ~/.fehbg &

# Set/Restore backlight
xbacklight -set 20 &

# Map caps lock to escape
(sleep 1 && setxkbmap -option caps:escape) &

# Start urxvt daemon
urxvtd &

# Merge .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Start X
exec dbus-launch --exit-with-session --sh-syntax awesome
