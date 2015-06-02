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


# -----------------------------------------------------
# ---------- Basic configuration
# -----------------------------------------------------

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="spcmd"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
#ZSH_CUSTOM=~/.oh-my-zsh/custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting)

# Setting the $PATH
export PATH="$HOME/bin:$HOME/Scripts:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

if [[ -d $HOME/.gem/ruby/2.2.0/bin ]]; then
    PATH=$PATH:$HOME/.gem/ruby/2.2.0/bin
fi

# oh-my-zsh
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

#Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

export TERM='rxvt-unicode-256color'
export COLORTERM='rxvt-unicode-256color'

# Stop ranger from loading the both the default and the custom config files
if [[ -f /usr/bin/ranger ]]; then
    export RANGER_LOAD_DEFAULT_RC=FALSE
fi

# Load dircolors
eval $(dircolors ~/.dircolors)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}  
alias ls='ls --color=auto'

# -----------------------------------------------------
# ---------- Vi mode in zsh
# -----------------------------------------------------

# Enable Vi/Vim mode
bindkey -v

# No delay entering normal mode
# https://coderwall.com/p/h63etq
# https://github.com/pda/dotzsh/blob/master/keyboard.zsh#L10
# 10ms for key sequences
KEYTIMEOUT=1

# Show vim status
# http://zshwiki.org/home/examples/zlewidgets
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Add missing vim hotkeys
# fixes backspace deletion issues
# http://zshwiki.org/home/zle/vi-mode
bindkey -a u undo
bindkey -a '^R' redo
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

# History search in vim mode
# http://zshwiki.org./home/zle/bindkeys#why_isn_t_control-r_working_anymore
bindkey -M viins '^s' history-incremental-search-backward
bindkey -M vicmd '^s' history-incremental-search-backward

# -----------------------------------------------------
# ---------- Custom vars
# -----------------------------------------------------

COLOR_DEFAULT=$(tput sgr0)
COLOR_TITLE=$(tput setaf 7; tput bold)
COLOR_HL1=$(tput setaf 4; tput bold)

# -----------------------------------------------------
# ---------- Zsh
# -----------------------------------------------------

# source/reload
alias RR='source ~/.zshrc && echo "source zshrc: done!"'

# -----------------------------------------------------
# ---------- Xorg
# -----------------------------------------------------

# reload .Xresources
rld-xresources() { xrdb -load ~/.Xresources && echo "reload .Xresources: done!" }

# -----------------------------------------------------
# ---------- Trash-CLI
# -----------------------------------------------------

# trash-cli aliases
alias trash-restore='restore-trash'

# trash-cli: list
TL() {
    echo -e "$COLOR_HL1::$COLOR_TITLE trash-cli >$COLOR_DEFAULT Listing Trash:"
    trash-list
}

# trash-cli: put
TP() {
    trash-put $@
    echo -e "$COLOR_HL1::$COLOR_TITLE trash-cli >$COLOR_DEFAULT Files have been put to Trash:"
    printf '%s\n' "$@"
}

# trash-cli: restore
TR() {
    echo -e "$COLOR_HL1::$COLOR_TITLE trash-cli >$COLOR_DEFAULT Restore file from Trash:"
    restore-trash
}

# trash-cli: empty
TE() {
    echo -e "$COLOR_HL1::$COLOR_TITLE trash-cli >$COLOR_DEFAULT Emptying Trash, are you sure? (y = yes)"
    read answer_trash
    if [[ $answer_trash == "y" ]] || [[ $answer_trash == "Y" ]]; then
        trash-empty 
        echo -e "$COLOR_HL1::$COLOR_TITLE trash-cli >$COLOR_DEFAULT Done! Trash is empty."
    else
        echo -e "$COLOR_HL1::$COLOR_TITLE trash-cli >$COLOR_DEFAULT Exit. Trash hasn't been emptied."
    fi
}

# -----------------------------------------------------
# ---------- Pacman
# -----------------------------------------------------

# pacman aliases
alias pacins='sudo pacman -S' # install
alias pacinu='sudo pacman -U' # istall local pkg
alias pacss='sudo pacman -Ss' # search
alias pacsync='sudo pacman -Syy' # update repo lists
alias pacupd='sudo pacman -Syyu' # update & upgrade
alias pacupg='sudo pacman -Syyu' # update & upgrade

# pacman: removed orphaned
pacrmo() {
    echo -e "$COLOR_HL1::$COLOR_TITLE sudo pacman -Rns \$(pacman -Qdtq) $COLOR_DEFAULT:: Remove all orphaned packages, their configuration files and unneeded dependecies.\n"
    sudo pacman -Rns $(pacman -Qdtq)
}

# pacman: remove packages
pacrm() {
    echo -e "$COLOR_HL1::$COLOR_TITLE sudo pacman -Rns $COLOR_DEFAULT:: Remove packages, their configuration files and unneeded dependecies.\n"
    sudo pacman -Rns $@ 
}

pacmirror() {
    echo -e "$COLOR_HL1::$COLOR_TITLE pacmirror >$COLOR_DEFAULT Use the new pacman mirrorlist as the default mirrorlist and create a backup of the current mirrorlist? (y = yes)"
    read answer_list
    if [[ $answer_list == "y" ]] || [[ $answer_list == "Y" ]]; then
        sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
        sudo mv /etc/pacman.d/mirrorlist.pacnew /etc/pacman.d/mirrorlist
        echo "New mirrorlist: done!"
        echo "Opening the new mirrorlist for editing."
        sudo vim /etc/pacman.d/mirrorlist
    else
        echo "pacmirror script stopped. Nothing changed."
    fi
}

# -----------------------------------------------------
# ---------- Git
# -----------------------------------------------------

# git
gitcheck() {
    echo -e "\n"
    echo -e "$COLOR_HL1::$COLOR_TITLE Checking:$COLOR_HL1 ~/git/spcmd.github.io $COLOR_DEFAULT"
    git -C ~/git/spcmd.github.io status
    echo -e "\n"
    echo -e "$COLOR_HL1::$COLOR_TITLE Checking:$COLOR_HL1 ~/git/themes $COLOR_DEFAULT"
    git -C ~/git/themes status
    echo -e "\n"
    echo -e "$COLOR_HL1::$COLOR_TITLE Checking:$COLOR_HL1 ~/Scripts $COLOR_DEFAULT"
    git -C ~/Scripts status
    echo -e "\n"
    echo -e "$COLOR_HL1::$COLOR_TITLE Checking:$COLOR_HL1 ~/dotfiles $COLOR_DEFAULT"
    git -C ~/dotfiles status
}

# git aliases
alias gch='gitcheck'
alias gadd='git add --all'
alias gpush='git push origin master'
alias gcommit='git commit -m'
alias gdiff='git diff'
alias cdgit='cd ~/git'

# -----------------------------------------------------
# ---------- Misc./Other stuff
# -----------------------------------------------------

# set compton-urxvt transparency
curxvtt() {
    compton_config=~/.config/compton/compton.conf
    if [[ -e  $compton_config ]]; then
        # change the 4th line
        sed -i "4s|.*|opacity-rule = [\"$1\:class_g = \'URxvt\' \&\& \!name = \'ranger\'\"];|" $compton_config 
        echo -e "$COLOR_HL1::$COLOR_TITLE urxvt transparency in compton.conf has been set to:$COLOR_HL1 $1 $COLOR_DEFAULT"
        echo -e "$COLOR_HL1::$COLOR_TITLE Restart compton? (y = yes) $COLOR_DEFAULT"
        read compton_restart
        if [[ $compton_restart == "y" ]] || [[ $compton_restart == "Y" ]]; then
            pkill compton &&
            sleep 1s &&
            compton -b --config $compton_config &&
            echo "Compton restart: done!"
        fi
    else
        echo -e "$COLOR_HL1::$COLOR_TITLE Error! $compton_config doesn't exist. $COLOR_DEFAULT"
    fi
}

# other aliases
alias lf='ls -AC'
alias hdapm='sudo hdparm -I /dev/sda | grep level'
alias jekyllserve='cd ~/.xampp/spcmd && echo "Serving: $(pwd)" && jekyll serve -w'
alias ytdla='youtube-dl --extract-audio --audio-format="mp3" --audio-quality=0 -o "~/Downloads/%(title)s.%(ext)s"'
alias ytdl='youtube-dl -f "best[height=720]" -o "~/Downloads/%(title)s.%(ext)s"'
alias gifview='gifview -aU' #gifsicle gifview: animated and unoptimized by default

# ssh with X (to run GUI apps)
alias sshx='ssh -X -C -c blowfish-cbc,arcfour'

# apt
apt-update() { sudo apt-get update && notify-send -i terminal "Update finished!" }
apt-upgrade() { sudo apt-get upgrade && notify-send -i terminal "Upgrade finished!" }
apt-install() { sudo apt-get install --no-install-recommends $1 && notify-send -i terminal "Finished installing $1" }
alias apt-remove='sudo apt-get remove --purge'
alias apt-ppa='sudo add-apt-repository'

# Colored man pages (https://wiki.archlinux.org/index.php/Man_page#Using_less_.28Recommended.29)
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}
