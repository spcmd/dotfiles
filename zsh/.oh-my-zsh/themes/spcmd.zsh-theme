# ========================================================= #
# spcmd theme for zsh                                       #
# Created by: spcmd                                         #
# Website: http://spcmd.github.io                           #
#          https://github.com/spcmd                         #
#          https://gist.github.com/spcmd                    #
# ========================================================= #

# The return status of the last command executed just before the prompt.
local return_status="%(?:%{$fg_bold[green]%}❯ :%{$fg_bold[green]%}❯ %s)"

PROMPT='%{$fg_bold[green]%}%~$(git_prompt_info)${return_status}%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[white]%}("
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]✓%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[white]%})"