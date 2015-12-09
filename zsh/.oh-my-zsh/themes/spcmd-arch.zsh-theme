#                                      _
#         ___ _ __   ___ _ __ ___   __| |
#        / __| '_ \ / __| '_ ` _ \ / _` |
#        \__ | |_) | (__| | | | | | (_| |
#        |___| .__/ \___|_| |_| |_|\__,_|
#             |_|
#
#              spcmd theme for zsh
#               Created by: spcmd
#           http://spcmd.github.io
#           https://github.com/spcmd
#           https://gist.github.com/spcmd


# Refresh prompt (time)
#TMOUT=60

#TRAPALRM() {
    #zle reset-prompt
#}

# symbols: ❯ ✓ ✗

# Minimal, one line
#PROMPT='%{$fg_bold[blue]%} %~ %{$fg_bold[white]%}$(git_prompt_info)%{$reset_color%}%% '

# Multiline
PROMPT='┌─[%{$fg[cyan]%} %M ───>%{$fg_bold[blue]%} %~ %{$fg_bold[white]%}$(git_prompt_info)%{$reset_color%}]
└─╼ '

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗%{$fg_bold[white]%})"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✓%{$fg_bold[white]%})"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
