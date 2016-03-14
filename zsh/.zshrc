#                                      _
#         ___ _ __   ___ _ __ ___   __| |
#        / __| '_ \ / __| '_ ` _ \ / _` |
#        \__ | |_) | (__| | | | | | (_| |
#        |___| .__/ \___|_| |_| |_|\__,_|
#             |_|
#
#                    .zshrc
#               Created by: spcmd
#           http://spcmd.github.io
#           https://github.com/spcmd
#           https://gist.github.com/spcmd

# {{{   ZSH Basic config
# -----------------------------------------------------

# Dir for ZSH
export ZSH=$HOME/.zsh

# Theme
ZSH_THEME="spcmd"

# Plugins
plugins=(zsh-syntax-highlighting)

# Options
autoload -U colors && colors
setopt auto_cd          # Change dir without the cd command
setopt multios          # Perform implicit tees or cats when multiple redirections are attempted
setopt cdablevars       # Try to expand the expression as if it were preceded by a ‘~’
setopt prompt_subst     # Needed for prompt coloring (expasion)
unsetopt nomatch        # Globbing

# Load ZSH stuff (defaults, plugins, themes)
source $ZSH/zsh-loader.sh

# Customize syntax highlight
#ZSH_HIGHLIGHT_STYLES[path]=''
#ZSH_HIGHLIGHT_STYLES[path_prefix]=''

# Load dircolors
if [[ -f ~/.dircolors ]]; then
    eval $(dircolors ~/.dircolors)
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# urxvt dynamic title (http://stackoverflow.com/a/20772424)
case $TERM in
  (*xterm* | *rxvt*)

    # Write some info to terminal title.
    # This is seen when the shell prompts for input.
    function precmd {
        print -Pn "\e]0;urxvt %(1j,%j job%(2j|s|); ,)%~\a"
    }
    # Write command and args to terminal title.
    # This is seen while the shell waits for a command to complete.
    function preexec {
        [[ $1 = "q" ]] && name="ranger" || name="$1" # fix title when switching to shell from ranger, then back to ranger (q is aliased to exit)
        printf "\033]0;%s\a" "$name"
    }

  ;;
esac

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
# {{{   Vi mode for Zsh
# -----------------------------------------------------

# Enable Vi mode
bindkey -v

# No delay entering normal mode
KEYTIMEOUT=1

# Mode & Cursor
# change cursor shape and color depending on the mode
#   1 or 0 : blinking block
#   2 : normal block
#   3 : blinking underscore
#   4 : normal underscore
#   5 : blinking vertical bar
#   6 : normal vertical bar

cursor_type_vicmd='2'
cursor_type_viins='2'
cursor_color_vicmd='yellow'
cursor_color_viins='cyan'

function zle-line-init zle-keymap-select {
    if [ $KEYMAP = vicmd ]; then
        echo -ne "\033[$cursor_type_vicmd q"
        echo -ne "\033]12;$cursor_color_vicmd\007"
    else
        echo -ne "\033[$cursor_type_viins q"
        echo -ne "\033]12;$cursor_color_viins\007"
    fi
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# Add missing hotkeys
# fixes backspace deletion issues
# http://zshwiki.org/home/zle/vi-mode
bindkey -a u undo
bindkey -a '^R' redo
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

# History search
# http://zshwiki.org./home/zle/bindkeys#why_isn_t_control-r_working_anymore
bindkey '^k' up-history
bindkey '^j' down-history
bindkey -M viins '^s' history-incremental-search-backward
bindkey -M vicmd '^s' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-backward

# }}}
# {{{  CLI Completions
# -----------------------------------------------------

# dm_dirbookmark
function _dm_completion {
	reply=($(sed 's/\(.*\)|.*/\1/' $HOME/.dirbookmarks))
}
compctl -K _dm_completion dm

# tvd
function _tvd_completion {
	reply=($(cat $HOME/.tvd_channels))
}
compctl -K _tvd_completion tvd

# }}}
# {{{   Source external functions/aliases
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
