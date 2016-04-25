# Shift+TAB moves backwards in completion
bindkey '^[[Z' reverse-menu-complete

# https://github.com/gotbletu/shownotes/blob/master/bang_previous_commands_hotkeys.md
# Bang! Previous Command Hotkeys
# print previous command but only the first nth arguments
# Alt+1, Alt+2 ...etc
#bindkey -s '\e1' "!:0 \t"
#bindkey -s '\e2' "!:0-1 \t"
#bindkey -s '\e3' "!:0-2 \t"
#bindkey -s '\e4' "!:0-3 \t"
#bindkey -s '\e5' "!:0-4 \t"
bindkey -s '^X' "!:0- \t"     # all but the last word
