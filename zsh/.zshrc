# ========================================================= #
# .zshrc                                                    #
# Created by: spcmd                                         #
# Website: http://spcmd.github.io                           #
#          https://github.com/spcmd                         #
#          https://gist.github.com/spcmd                    #
# ========================================================= #

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
# ENABLE_CORRECTION="true"

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

# User configuration

export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

#Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
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
alias zcat='history | tail -n 15'
alias zz='source ~/.zshrc && echo "source zshrc: done!"'

#dev
alias jekyllserve='cd ~/.xampp/spcmd && echo "Serving: $(pwd)" && jekyll serve -w'
alias cdgit='cd ~/git'
alias gadd='git add --all'
alias gpush='git push origin master'
alias gcommit='git commit -m'
alias gdiff='git diff'

#misc
alias lf='ls -ACF'
alias hdapm='sudo hdparm -I /dev/sda | grep level'
alias faenzaicon='find /usr/share/icons/Faenza -type f | grep'
alias findicon='find /usr/share/icons -type f | grep'
alias ytdla='youtube-dl --extract-audio --audio-format="mp3" --audio-quality=0 -o "~/Downloads/%(title)s.%(ext)s"'
alias ytdl='youtube-dl -f "best[height=720]" -o "~/Downloads/%(title)s.%(ext)s"'
