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
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

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

# ============================== #
# ========== Vi MODE  ========== #
# ============================== #

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

# Load dircolors (needed for termite)
eval $(dircolors ~/.dircolors)

# ====================================================== #
# ========== CUSTOM VARS, FUNCTIONS & ALIASES ========== #
# ====================================================== #

# backup
DIR_BACKUP=~/Backup
alias bak_rclua='cp ~/.config/awesome/rc.lua $DIR_BACKUP && echo "rc.lua copied to: $DIR_BACKUP"'

# apt
apt-update() { sudo apt-get update && notify-send -i terminal "Update finished!" }
apt-upgrade() { sudo apt-get upgrade && notify-send -i terminal "Upgrade finished!" }
apt-install() { sudo apt-get install --no-install-recommends $1 && notify-send -i terminal "Finished installing $1" }
alias apt-remove='sudo apt-get remove --purge'
alias apt-ppa='sudo add-apt-repository'

# pacman
pacmirror() {
    echo "Use the new pacman mirrorlist as the default mirrorlist and create a backup of the current mirrorlist? (y = yes)"
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

# zsh
alias zcat='history | tail -n 15'
alias zz='source ~/.zshrc && echo "source zshrc: done!"'

# dev/git
alias jekyllserve='cd ~/.xampp/spcmd && echo "Serving: $(pwd)" && jekyll serve -w'
alias cdgit='cd ~/git'
alias gadd='git add --all'
alias gpush='git push origin master'
alias gcommit='git commit -m'
alias gdiff='git diff'

# Checking local git repos
gitcheck() {
    col_def=$(tput sgr0)
    col_title=$(tput setaf 7; tput bold)
    col_dir=$(tput setaf 4; tput bold)

    echo -e "\n"
    echo -e "$col_dir::$col_title Checking:$col_dir ~/git/spcmd.github.io $col_def"
    git -C ~/git/spcmd.github.io status
    echo -e "\n"
    echo -e "$col_dir::$col_title Checking:$col_dir ~/git/themes $col_def"
    git -C ~/git/themes status
    echo -e "\n"
    echo -e "$col_dir::$col_title Checking:$col_dir ~/Scripts $col_def"
    git -C ~/Scripts status
    echo -e "\n"
    echo -e "$col_dir::$col_title Checking:$col_dir ~/dotfiles $col_def"
    git -C ~/dotfiles status
}

# ssh with X (to run GUI apps)
alias sshx='ssh -X -C -c blowfish-cbc,arcfour'

# misc
alias lf='ls -ACF'
alias hdapm='sudo hdparm -I /dev/sda | grep level'
alias faenzaicon='find /usr/share/icons/Faenza -type f | grep'
alias findicon='find /usr/share/icons -type f | grep'
alias ytdla='youtube-dl --extract-audio --audio-format="mp3" --audio-quality=0 -o "~/Downloads/%(title)s.%(ext)s"'
alias ytdl='youtube-dl -f "best[height=720]" -o "~/Downloads/%(title)s.%(ext)s"'
alias gifview='gifview -aU' #gifsicle gifview: animated and unoptimized by default
