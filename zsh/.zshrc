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

# Load theme
[[ -f $DIR_ZSH_THEMES/$ZSH_THEME.zsh-theme ]] && . $DIR_ZSH_THEMES/$ZSH_THEME.zsh-theme

# Load plugins
[[ -f $DIR_ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && . $DIR_ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load and run compinit (needed for completion)
autoload -U compinit
compinit -i -d "${FILE_ZSH_COMPDUMP}"


# }}}
# {{{   ENV Variables / Dirs / Paths
# -----------------------------------------------------

export EDITOR='vim'
export TERM='rxvt-unicode-256color'
export COLORTERM='rxvt-unicode-256color'
export MEDIAPLAYER='mpv'
export IMAGER='feh'
export PDFER='zathura'

export DIR_BACKUP=$HOME/Backup
export DIR_SCRIPTS=$HOME/Scripts
export DIR_ALIASES_FUNCTIONS=$HOME/.aliases_functions
export DIR_WEBDEV=$HOME/.webdev

export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_TEMPLATES_DIR="$HOME/.Templates"
export XDG_VIDEOS_DIR="$HOME/Videos"

# Stop ranger from loading the both the default and the custom config files
export RANGER_LOAD_DEFAULT_RC=FALSE

# Setting the $PATH
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games"
[[ -d $DIR_SCRIPTS ]] && PATH=$PATH:$DIR_SCRIPTS
[[ -d $HOME/bin ]] && PATH=$PATH:$HOME/bin

# }}}
# {{{   Functions/Aliases
# -----------------------------------------------------

[[ -f $DIR_ALIASES_FUNCTIONS/audio-video ]] && . $DIR_ALIASES_FUNCTIONS/audio-video
[[ -f $DIR_ALIASES_FUNCTIONS/awesome_wm ]] && . $DIR_ALIASES_FUNCTIONS/awesome_wm
[[ -f $DIR_ALIASES_FUNCTIONS/backup ]] && . $DIR_ALIASES_FUNCTIONS/backup
[[ -f $DIR_ALIASES_FUNCTIONS/compton ]] && . $DIR_ALIASES_FUNCTIONS/compton
[[ -f $DIR_ALIASES_FUNCTIONS/config_files ]] && . $DIR_ALIASES_FUNCTIONS/config_files
[[ -f $DIR_ALIASES_FUNCTIONS/coreutils ]] && . $DIR_ALIASES_FUNCTIONS/coreutils
[[ -f $DIR_ALIASES_FUNCTIONS/dm_dirbookmark ]] && . $DIR_ALIASES_FUNCTIONS/dm_dirbookmark
[[ -f $DIR_ALIASES_FUNCTIONS/git ]] && . $DIR_ALIASES_FUNCTIONS/git
[[ -f $DIR_ALIASES_FUNCTIONS/hugo ]] && . $DIR_ALIASES_FUNCTIONS/hugo
[[ -f $DIR_ALIASES_FUNCTIONS/misc ]] && . $DIR_ALIASES_FUNCTIONS/misc
[[ -f $DIR_ALIASES_FUNCTIONS/mutt ]] && . $DIR_ALIASES_FUNCTIONS/mutt
[[ -f $DIR_ALIASES_FUNCTIONS/net_utils ]] && . $DIR_ALIASES_FUNCTIONS/net_utils
[[ -f $DIR_ALIASES_FUNCTIONS/pacman ]] && . $DIR_ALIASES_FUNCTIONS/pacman
[[ -f $DIR_ALIASES_FUNCTIONS/password ]] && . $DIR_ALIASES_FUNCTIONS/password
[[ -f $DIR_ALIASES_FUNCTIONS/start-sleep-shutdown ]] && . $DIR_ALIASES_FUNCTIONS/start-sleep-shutdown
[[ -f $DIR_ALIASES_FUNCTIONS/wifi-network ]] && . $DIR_ALIASES_FUNCTIONS/wifi-network
[[ -f $DIR_ALIASES_FUNCTIONS/xampp-lampp ]] && . $DIR_ALIASES_FUNCTIONS/xampp-lampp

# }}}
