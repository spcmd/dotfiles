#                               _
#  ___ _ __   ___ _ __ ___   __| |
# / __| '_ \ / __| '_ ` _ \ / _` |
# \__ | |_) | (__| | | | | | (_| |
# |___| .__/ \___|_| |_| |_|\__,_|
#     |_|
# Created by: spcmd
# http://spcmd.github.io
# https://github.com/spcmd

# This file is sourced only for login shells (i.e. shells
# invoked with "-" as the first character of argv[0], and
# shells invoked with the -l flag.)
#
# Global Order: zshenv, zprofile, zshrc, zlogin

# ------------------------------------
# Colors for the console (linux term)
# ------------------------------------
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0000000" #black
    echo -en "\e]P8555555" #darkgrey
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
    #clear #for background artifacting
fi

# ------------------------------------
# Env Vars
# ------------------------------------

# Applications
export BROWSER='luakit'
export EDITOR='vim'
export TERM='rxvt-unicode-256color'
export COLORTERM='rxvt-unicode-256color'
export MEDIAPLAYER='mpv'
export IMAGER='feh'
export PDFER='zathura'

# FIM (http://www.nongnu.org/fbi-improved/)
export FBFONT=/usr/share/kbd/consolefonts/ter-216b.psf.gz

# Ranger: Don't load the default config
export RANGER_LOAD_DEFAULT_RC=FALSE

# fzf default options
export FZF_DEFAULT_OPTS="--extended --exact --reverse --bind=tab:down,btab:up,ctrl-j:page-down,ctrl-k:page-up --color=prompt:3"

# Directories
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

# Path
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games"
[[ -d $DIR_SCRIPTS ]] && PATH=$PATH:$DIR_SCRIPTS
[[ -d $HOME/bin ]] && PATH=$PATH:$HOME/bin

# Auto startx
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
