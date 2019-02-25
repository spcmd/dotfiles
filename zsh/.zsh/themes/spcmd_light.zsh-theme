# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
# http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

# black minimal
PROMPT='%B%F{0}\
%F{24}%~\
$(git_prompt_info)\
%B%F{0}> \
%{$reset_color%}'

# black normal
#PROMPT='%B%F{0}%n@%m \
#%F{24}%~\
#$(git_prompt_info) \
#%F{0}> \
#%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{0}("
ZSH_THEME_GIT_PROMPT_DIRTY="%F{196}[X]%F{0})"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{34}[0]%F{0})"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
