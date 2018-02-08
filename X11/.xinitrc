# Num lock ON
[[ -x /usr/bin/numlockx ]] && /usr/bin/numlockx &

# Set the wallpaper
sh ~/.fehbg

# Set/Restore backlight
light -S 20

# Map caps lock to escape
#  note: this doesn't work with ~/.Xmodmap
(sleep 0.2 && setxkbmap -option caps:escape)

# Source Xmodmap (not needed anymore, using libinput.conf instead)
#xmodmap ~/.Xmodmap

# Start urxvt daemon
#[[ ! $(pgrep urxvtd) ]] && urxvtd &
urxvtd -q -f -o

# Merge .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Generate dwatch cache
#[[ -x ~/Scripts/dwatch ]] && sh ~/Scripts/dwatch update

# Redshift
[[ ! $(pgrep redshift) ]] && redshift -r -c ~/.config/redshift/redshift.conf &

# Disable screen blanking/screensaver
xset -dpms
xset s off

# Autocutsel (Sync PRIMARY and CLIPBOARD selection)
#autocutsel -fork &
#autocutsel -selection PRIMARY -fork &

# Gnome keyring (needed for mailspring)
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Start X
#exec dbus-launch --exit-with-session --sh-syntax awesome
#exec awesome
sxhkd &
exec bspwm
