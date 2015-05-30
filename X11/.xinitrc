
# Num lock ON
if [[ -e /usr/bin/numlockx ]]; then
    /usr/bin/numlockx &
fi

# Source Xmodmap
xmodmap ~/.Xmodmap &

# Set the wallpaper
sh ~/.fehbg &

# Set keyboard layout
# disabled (set with 'localectl set-x11-keymap hu')
#setxkbmap hu &

# Map caps lock to escape
(sleep 1 && setxkbmap -option caps:escape) &

# Start urxvt daemon
urxvtd &

# Policy shit
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Start X
exec dbus-launch --exit-with-session --sh-syntax awesome
