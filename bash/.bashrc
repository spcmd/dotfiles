#                                      _
#         ___ _ __   ___ _ __ ___   __| |
#        / __| '_ \ / __| '_ ` _ \ / _` |
#        \__ | |_) | (__| | | | | | (_| |
#        |___| .__/ \___|_| |_| |_|\__,_|
#             |_|
#
#                   .bashrc
#               Created by: spcmd
#           http://spcmd.github.io
#           https://github.com/spcmd
#           https://gist.github.com/spcmd

# ================================= #
# ========== BASIC STUFF ========== #
# ================================= #

export EDITOR="vim"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history
HISTCONTROL="ignoreboth"

# don't put these commands in the history
HISTIGNORE="history:clear"

# append to the history file, don't overwrite it
shopt -s histappend

# history length (lines & files size)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
#     export TERM=xterm-256color
# fi

# color prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
      #PS1="\[$(tput bold)\]\[$(tput setaf 7)\]\u\[$(tput setaf 2)\] >\[$(tput setaf 4)\] \w\[$(tput setaf 2)\] $ \[$(tput sgr0)\]"
      PS1="\[$(tput bold)\]\[\e[44m\] \[\e[37;44m\]\w\[\e[m\]\[\e[44m\] \[\e[m\]\[\e[44m\]> \[\e[m\] "

else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

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
