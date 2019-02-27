# Num lock ON
[[ -x /usr/bin/numlockx ]] && /usr/bin/numlockx &

# Set the wallpaper
sh ~/.fehbg

# Set/Restore backlight
light -S 20

# Map caps lock to escape
#  note: this doesn't work with ~/.Xmodmap
(sleep 0.2 && setxkbmap -option caps:escape)

# Map Home to Ctrl (external keyboard Home key fix)
sleep 0.5 && xmodmap -e "keycode 110 = Control_L"

# Mouse speed (for the USB mouse)
xset m 2/1 6

# Source Xmodmap (not needed anymore, using libinput.conf instead)
#xmodmap ~/.Xmodmap

# Start urxvt daemon
#[[ ! $(pgrep urxvtd) ]] && urxvtd &
urxvtd -q -f -o

# Merge .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Redshift
[[ ! $(pgrep redshift) ]] && redshift -r -c ~/.config/redshift/redshift.conf &

# Disable screen blanking/screensaver
xset -dpms
xset s off

# Autocutsel (Sync PRIMARY and CLIPBOARD selection)
#autocutsel -fork &
#autocutsel -selection PRIMARY -fork &

# Gnome keyring
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Udiskie (Automount removable drives)
udiskie &

# Play-with-mpv (https://github.com/Thann/play-with-mpv)
#play-with-mpv &

# fcitx input method
fcitx &

# Natural scroll xinput ("id" might be updated)
# rewrite 8 9 to 0 0 to disable side buttons
#xinput set-button-map 10 1 2 3 5 4 6 7 8 9
xinput set-button-map 10 1 2 3 5 4 6 7 0 0

# Start X
#exec dbus-launch --exit-with-session --sh-syntax awesome
#exec awesome
#sxhkd &
#exec bspwm
exec i3
