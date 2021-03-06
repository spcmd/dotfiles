#                               _
#  ___ _ __   ___ _ __ ___   __| |
# / __| '_ \ / __| '_ ` _ \ / _` |
# \__ | |_) | (__| | | | | | (_| |
# |___| .__/ \___|_| |_| |_|\__,_|
#     |_|
# Created by: spcmd
# http://spcmd.github.io
# https://github.com/spcmd

# List text files/scripts from the selected dirs with fzf and open them in Vim
# xargs vim info: http://superuser.com/questions/336016/invoking-vi-through-find-xargs-breaks-my-terminal-why/427881#427881
fzf-vim-open() {
    dirs=(~/.aliases_functions ~/.dsnippet ~/.webdev ~/dotfiles ~/Documents ~/Scripts)
    list=$(find "${dirs[@]}" -type f ! -iregex ".*[/]\.git[/]?.*\|^.+\.png$\|^.+\.jpg$\|^.+\.psd$\|^.+\.pdf$\|^.+\.odt$\|^.+\.ods$\|^.+\.docx?$\|^.+\.xlsx?$" | fzf --color=prompt:155,pointer:155,hl:155,hl+:198 --prompt "fzf-vim-open> ")
    # Run Vim only if something was selected
    [[ ! -z $list ]] && echo "$list" | xargs bash -c '</dev/tty vim "$@"' ignoreme
}
zle -N fzf-vim-open
bindkey '^O' fzf-vim-open

# Search history with fzf
fzf-history () { RBUFFER=$(fc -ln -500 | fzf --tac --no-sort --color=prompt:166 --prompt "history> ") $RBUFFER; }
zle -N fzf-history
bindkey -M vicmd '^s' fzf-history
bindkey -M viins '^s' fzf-history
