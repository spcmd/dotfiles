#                               _
#  ___ _ __   ___ _ __ ___   __| |
# / __| '_ \ / __| '_ ` _ \ / _` |
# \__ | |_) | (__| | | | | | (_| |
# |___| .__/ \___|_| |_| |_|\__,_|
#     |_|
# Created by: spcmd
# http://spcmd.github.io
# https://github.com/spcmd

# {{{   ZSH Basic config
# -----------------------------------------------------

DIR_ZSH=$HOME/.zsh
DIR_ZSH_DEFAULTS=$DIR_ZSH/defaults
DIR_ZSH_COMPLETIONS=$DIR_ZSH/completions
DIR_ZSH_THEMES=$DIR_ZSH/themes
FILE_ZSH_COMPDUMP="$HOME/.zcompdump"

# Theme / Prompt
ZSH_THEME="spcmd"

# Load defaults
for default_config in $DIR_ZSH_DEFAULTS/*.zsh; do
    . $default_config
done

# Load completions
for completion in $DIR_ZSH_COMPLETIONS/*.zsh-completion; do
    . $completion
done

# Prompt / Theme
# if opening a shell from Vim, indicate it in the prompt
if [[ $VIM ]]; then
    . $DIR_ZSH_THEMES/$ZSH_THEME.zsh-theme
    PROMPT="${PROMPT}(Vim) "
else
    . $DIR_ZSH_THEMES/$ZSH_THEME.zsh-theme
fi

# Load plugins
[[ -f $DIR_ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && . $DIR_ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load and run compinit (needed for completion)
autoload -U compinit
compinit -i -d "${FILE_ZSH_COMPDUMP}"

# Base16 Shell (https://github.com/chriskempson/base16-shell)
#BASE16_SHELL="$HOME/.config/base16-shell/base16-tomorrow.dark.sh"
#[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Disable Sotfware Flow Control (hanging the terminal with Ctrl+S)
stty -ixon

# }}}
# {{{   Functions/Aliases
# -----------------------------------------------------

[[ -f $DIR_ALIASES_FUNCTIONS/audio-video ]] && . $DIR_ALIASES_FUNCTIONS/audio-video
#[[ -f $DIR_ALIASES_FUNCTIONS/awesome_wm ]] && . $DIR_ALIASES_FUNCTIONS/awesome_wm
[[ -f $DIR_ALIASES_FUNCTIONS/backup ]] && . $DIR_ALIASES_FUNCTIONS/backup
[[ -f $DIR_ALIASES_FUNCTIONS/bspwm ]] && . $DIR_ALIASES_FUNCTIONS/bspwm
#[[ -f $DIR_ALIASES_FUNCTIONS/compton ]] && . $DIR_ALIASES_FUNCTIONS/compton
[[ -f $DIR_ALIASES_FUNCTIONS/config_files ]] && . $DIR_ALIASES_FUNCTIONS/config_files
[[ -f $DIR_ALIASES_FUNCTIONS/coreutils ]] && . $DIR_ALIASES_FUNCTIONS/coreutils
[[ -f $DIR_ALIASES_FUNCTIONS/dm_dirbookmark ]] && . $DIR_ALIASES_FUNCTIONS/dm_dirbookmark
[[ -f $DIR_ALIASES_FUNCTIONS/git ]] && . $DIR_ALIASES_FUNCTIONS/git
#[[ -f $DIR_ALIASES_FUNCTIONS/hugo ]] && . $DIR_ALIASES_FUNCTIONS/hugo
[[ -f $DIR_ALIASES_FUNCTIONS/iso ]] && . $DIR_ALIASES_FUNCTIONS/iso
[[ -f $DIR_ALIASES_FUNCTIONS/misc ]] && . $DIR_ALIASES_FUNCTIONS/misc
[[ -f $DIR_ALIASES_FUNCTIONS/mutt ]] && . $DIR_ALIASES_FUNCTIONS/mutt
[[ -f $DIR_ALIASES_FUNCTIONS/net_utils ]] && . $DIR_ALIASES_FUNCTIONS/net_utils
[[ -f $DIR_ALIASES_FUNCTIONS/pacman ]] && . $DIR_ALIASES_FUNCTIONS/pacman
[[ -f $DIR_ALIASES_FUNCTIONS/password ]] && . $DIR_ALIASES_FUNCTIONS/password
[[ -f $DIR_ALIASES_FUNCTIONS/start-sleep-shutdown ]] && . $DIR_ALIASES_FUNCTIONS/start-sleep-shutdown
[[ -f $DIR_ALIASES_FUNCTIONS/tmux ]] && . $DIR_ALIASES_FUNCTIONS/tmux
[[ -f $DIR_ALIASES_FUNCTIONS/wifi-network ]] && . $DIR_ALIASES_FUNCTIONS/wifi-network
[[ -f $DIR_ALIASES_FUNCTIONS/xampp-lampp ]] && . $DIR_ALIASES_FUNCTIONS/xampp-lampp

# }}}
