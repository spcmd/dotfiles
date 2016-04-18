# This file is sourced only for login shells (i.e. shells
# invoked with "-" as the first character of argv[0], and
# shells invoked with the -l flag.)
#
# Global Order: zshenv, zprofile, zshrc, zlogin

# ENV Variables
export BROWSER='luakit'
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

# Auto startx
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
