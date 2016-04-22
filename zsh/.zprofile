# This file is sourced only for login shells (i.e. shells
# invoked with "-" as the first character of argv[0], and
# shells invoked with the -l flag.)
#
# Global Order: zshenv, zprofile, zshrc, zlogin

# Set colors for the console
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0000000" #black
    echo -en "\e]P8202020" #darkgrey
    echo -en "\e]P1de100c" #darkred
    echo -en "\e]P9ff434a" #red
    echo -en "\e]P200930C" #darkgreen
    echo -en "\e]PA46cb50" #green
    echo -en "\e]P3fae56b" #brown
    echo -en "\e]PBfdff0f" #yellow
    echo -en "\e]P42d92dd" #darkblue
    echo -en "\e]PC2d92dd" #blue
    echo -en "\e]P5d281ce" #darkmagenta
    echo -en "\e]PDd281ce" #magenta
    echo -en "\e]P600c1c1" #darkcyan
    echo -en "\e]PE00f0f0" #cyan
    echo -en "\e]P7ffffff" #white
    echo -en "\e]PFffffff" #lightgrey
    clear #for background artifacting
fi

# Env Vars
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
