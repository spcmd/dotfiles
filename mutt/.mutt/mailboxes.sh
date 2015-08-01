#!/bin/bash
#                                      _
#         ___ _ __   ___ _ __ ___   __| |
#        / __| '_ \ / __| '_ ` _ \ / _` |
#        \__ | |_) | (__| | | | | | (_| |
#        |___| .__/ \___|_| |_| |_|\__,_|
#             |_|
#
#                  mailboxes.sh
#               Created by: spcmd
#           http://spcmd.github.io
#           https://github.com/spcmd
#           https://gist.github.com/spcmd
#
#  This scripts allows you to add/remove folder (label)
#  names to/from the "mailboxes" list in the account file,
#  (or muttrc) where the mailboxes are listed.
#  When added, the folder names will be appended to the 
#  end of the line.
#  
#  Usage: 
#    1.) Define the "$my_script_mailboxes" variable in your muttrc:
#        set $my_script_mailboxes = /path/to/this/mailboxes.sh   (Note: user defines variables must start with "$my_")
#
#    2.) Add these macros to your account file (or muttrc) where the mailboxes are listed:
#        macro browser a "<shell-escape>$my_script_mailboxes --acc_file ~/.mutt/your_account_file.muttrc --add <LABELNAME>" "Add Label/Folder to mailboxes in the account file"
#        macro browser r "<shell-escape>$my_script_mailboxes --acc_file ~/.mutt/your_account_file.muttrc --remove <LABELNAME>" "Remove Label/Folder from mailboxes in the account file"
#
#    3.) In mutt, at the browser screen (where the folders are listed) press "a" to add, or "r" to remove label.

acc_file=$2
option=$3
labelname=$4

case $option in
    --add) 
        sed -i "/^mailboxes/s/$/ \+$labelname/" $acc_file && notify-send "mutt mailboxes.sh" "$labelname added to: $acc_file";;
    --remove)
        sed -i "/^mailboxes/ s/\+$labelname//" $acc_file && notify-send "mutt mailboxes.sh" "$labelname removed from: $acc_file";;
esac 
