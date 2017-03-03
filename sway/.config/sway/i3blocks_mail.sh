#!/bin/sh

mail_count=$(cat ~/.mutt/newmail_count)

if [ "$mail_count" -gt 0 ]; then
    mail_count="<span foreground='red'>${mail_count}new</span>"
else
    mail_count=$mail_count
fi

echo "$mail_count"
