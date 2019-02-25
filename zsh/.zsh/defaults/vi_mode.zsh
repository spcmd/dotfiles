# Enable Vi mode
bindkey -v

# No delay entering normal mode
KEYTIMEOUT=1

# Mode & Cursor
# change cursor shape and color depending on the mode
#   1 or 0 : blinking block
#   2 : normal block
#   3 : blinking underscore
#   4 : normal underscore
#   5 : blinking vertical bar
#   6 : normal vertical bar

cursor_type_vicmd='2'
cursor_type_viins='6'
cursor_color_vicmd='15'
#cursor_color_viins='12'
cursor_color_viins='0'

function zle-line-init zle-keymap-select {
    if [ $KEYMAP = vicmd ]; then
        echo -ne "\033[$cursor_type_vicmd q"
        echo -ne "\033]12;$cursor_color_vicmd\007"
    else
        echo -ne "\033[$cursor_type_viins q"
        echo -ne "\033]12;$cursor_color_viins\007"
    fi
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}

# Paste (based on: http://unix.stackexchange.com/questions/25765/pasting-from-clipboard-to-vi-enabled-zsh-or-bash-shell/25839#25839)
vi-paste-from-clipboard () { RBUFFER=$(echo " $(xsel -o -b </dev/null)")$RBUFFER; }

zle -N zle-line-init
zle -N zle-keymap-select
zle -N vi-paste-from-clipboard

# Add missing hotkeys
# fixes backspace deletion issues
# http://zshwiki.org/home/zle/vi-mode
bindkey -a u undo
bindkey -a '^R' redo
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

# History search
# http://zshwiki.org./home/zle/bindkeys#why_isn_t_control-r_working_anymore
bindkey '^k' up-history
bindkey '^j' down-history
bindkey -M vicmd '/' history-incremental-search-backward

# Paste
bindkey -M vicmd 'p' vi-paste-from-clipboard
