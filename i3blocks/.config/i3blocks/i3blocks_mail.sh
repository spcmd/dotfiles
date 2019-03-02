#!/bin/sh

mail_count=$(cat ~/.mutt/newmail_count)

if [ "$mail_count" -gt 0 ]; then
    #mail_count="<span foreground='#ff0000'>${mail_count}new</span>"
    #mail_count="<span foreground='#DE0404'>${mail_count}new</span>"
    mail_count="<span foreground='#c21e00'> ${mail_count}</span>"
else
    #mail_count=$mail_count
    mail_count=
fi

echo "$mail_count"

# mouse button clicks
case $BLOCK_BUTTON in
    1) i3-msg exec "urxvtc -name neomutt -e neomutt -F ~/.mutt/account.1.muttrc" ;;
    2) i3-msg exec "notify-send 'gmailcheck' 'Checking mail...' && $DIR_SCRIPTS/gmailcheck.sh && notify-send 'gmailcheck' 'Check done.'&& pkill -RTMIN+2 i3blocks" ;;
    3) i3-msg exec "urxvtc -name neomutt -e neomutt -F ~/.mutt/account.2.muttrc" ;;
esac
