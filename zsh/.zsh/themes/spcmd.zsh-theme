# symbols: ❯ ✓ ✗

# Old
#PROMPT='%{$fg_bold[green]%}%~%{$fg_bold[white]%}$(git_prompt_info)%{$fg_bold[green]%}> %{$reset_color%}'

# New
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
# http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

# green minimal
#PROMPT='%B%F{40}%~\
#$(git_prompt_info)\
#%B%F{40}> \
#%{$reset_color%}'

# grey host
#PROMPT='%B%F{7}%n@%m \
#%F{4}%~\
#$(git_prompt_info) \
#%F{7}> \
#%{$reset_color%}'

# green host
PROMPT='%B%F{40}%n@%m \
%F{4}%~\
$(git_prompt_info) \
%F{40}$ \
%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{255}("
ZSH_THEME_GIT_PROMPT_DIRTY="%F{196}✗%F{255})"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{48}✓%F{255})"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
