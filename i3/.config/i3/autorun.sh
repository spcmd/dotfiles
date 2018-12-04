# ------------------------------------------------------------
# Autorun these when starting i3
# ------------------------------------------------------------

gmailcheck() {
    while true; do
        $DIR_SCRIPTS/gmailcheck.sh
        sleep 5m
    done
}

tvmusor() {
    $DIR_SCRIPTS/tvm -G | gist -u 258bad5f3ca1995fc3d595cf359a36c3 -p -f "TV musor"
}

# start these programs only once
if [ ! -e /tmp/i3_autorun ]; then
    urxvtc &
    urxvtc -name ranger -e ranger &
    urxvtc -name newsboat -e newsboat &
    #urxvtc -name rtorrent -e rtorrent &
    ~/bin/chromium-privoxy.sh &
    sleep 5s && geary-light-theme.sh &
    echo "false" > /tmp/i3_autorun
    #sleep 4m && tvmusor &
fi

gmailcheck &