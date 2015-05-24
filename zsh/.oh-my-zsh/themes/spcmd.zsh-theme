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


# The return status of the last command executed just before the prompt.
local return_status="%(?:%{$fg_bold[green]%}❯ :%{$fg_bold[green]%}❯ )"

PROMPT='%{$fg_bold[green]%}%~$(git_prompt_info)${return_status}%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[white]%}("
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]✓%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[white]%})"
