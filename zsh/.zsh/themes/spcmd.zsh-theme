# symbols: ❯ ✓ ✗
PROMPT='%{$fg_bold[green]%}%~%{$fg_bold[white]%}$(git_prompt_info)%{$fg_bold[green]%}> %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗%{$fg_bold[white]%})"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✓%{$fg_bold[white]%})"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
