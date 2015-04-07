# ========================================================= #
# .bashrc                                                   #
# Created by: spcmd                                         #
# Website: http://spcmd.github.io                           #
#          https://github.com/spcmd                         #
#          https://gist.github.com/spcmd                    #
# ========================================================= #

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

# ====================================== #
# ========== CUSTOM FUNCTIONS ========== #
# ====================================== #

updatefunc() {
    sudo apt-get update && notify-send -i terminal "Update finished!"
}
upgradefunc() {
    sudo apt-get upgrade && notify-send -i terminal "Upgrade finished!"
}
installfunc() {
    sudo apt-get install --no-install-recommends $1 && notify-send -i terminal "Finished installing $1"
}

# ==================================== #
# ========== CUSTOM ALIASES ========== #
# ==================================== #

# apt
alias update=updatefunc
alias upgrade=upgradefunc
alias install=installfunc
alias remove='sudo apt-get remove --purge'
alias repo='sudo add-apt-repository'

# bash
alias bcat='history | tail -n 15'
alias bashrc='source ~/.bashrc && echo "source bashrc: done!"'

#dev
alias jekyllserve='cd ~/.xampp/spcmd && echo "Serving: $(pwd)" && jekyll serve -w'
alias cdgit='cd ~/git'
alias gitadd='git add --all'
alias gitpush='git push origin master'

#misc
alias lf='ls -ACF'
alias hdapm='sudo hdparm -I /dev/sda | grep level'
alias faenzaicon='find /usr/share/icons/Faenza -type f | grep'
alias findicon='find /usr/share/icons -type f | grep'
alias ytdla='youtube-dl --extract-audio --audio-format="mp3" --audio-quality=0 -o "~/Downloads/%(title)s.%(ext)s"'
alias ytdl='youtube-dl -f "best[height=720]" -o "~/Downloads/%(title)s.%(ext)s"'

