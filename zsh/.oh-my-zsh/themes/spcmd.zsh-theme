# ========================================================= #
# spcmd theme for zsh                                       #
# Created by: spcmd                                         #
# Website: http://spcmd.github.io                           #
#          https://github.com/spcmd                         #
#          https://gist.github.com/spcmd                    #
# ========================================================= #

# The return status of the last command executed just before the prompt.
local return_status="%(?:%{$fg_bold[white]%}➜ :%{$fg_bold[red]%}➜ %s)"

PROMPT='${return_status}%{$fg_bold[blue]%}%~ %{$fg_bold[white]%}$(git_prompt_info) %{$reset_color%}'

#ZSH_THEME_GIT_PROMPT_PREFIX="[%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]✓%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"