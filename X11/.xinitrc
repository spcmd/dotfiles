# Num lock ON
[[ -x /usr/bin/numlockx ]] && /usr/bin/numlockx &

# Source Xmodmap
xmodmap ~/.Xmodmap

# Set the wallpaper
sh ~/.fehbg

# Set/Restore backlight
#xbacklight -set 20 &
light -S 20

# Map caps lock to escape
(sleep 1 && setxkbmap -option caps:escape)

# Start urxvt daemon
urxvtd &

# Merge .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Set Font path
#xset +fp ~/.local/share/fonts/terminus &

# Generate dwatch cache
#[[ -x ~/Scripts/dwatch ]] && sh ~/Scripts/dwatch update

# Redshift
redshift -r -c ~/.config/redshift/redshift.conf &

# Start X
#exec dbus-launch --exit-with-session --sh-syntax awesome
exec awesome
