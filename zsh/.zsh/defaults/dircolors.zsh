if [[ -f ~/.dircolors ]]; then
    eval $(dircolors ~/.dircolors)
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi
