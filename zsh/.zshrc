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

# Path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# Zsh Theme (~/.oh-my-zsh/themes/)
ZSH_THEME="spcmd"

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

# Plugins (~/.oh-my-zsh/plugins/*)
# Custom plugins (~/.oh-my-zsh/custom/plugins/)
plugins=(git zsh-syntax-highlighting)

# globbing
unsetopt nomatch

# oh-my-zsh
# some default zsh scripts were disabled in ".oh-my-zsh/lib" by "oh-my-zsh/.gitignore"
source $ZSH/oh-my-zsh.sh

# Load dircolors
if [[ -f ~/.dircolors ]]; then
    eval $(dircolors ~/.dircolors)
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# }}}
# {{{   ENV Variables
# -----------------------------------------------------

export EDITOR='vim'
export TERM='rxvt-unicode-256color'
export COLORTERM='rxvt-unicode-256color'
export MEDIAPLAYER='mpv'
export IMAGER='feh'
export PDFER='zathura'
export DIR_BACKUP=$HOME/Backup
export DIR_SCRIPTS=$HOME/Scripts

# Stop ranger from loading the both the default and the custom config files
if [[ -f /usr/bin/ranger ]]; then
    export RANGER_LOAD_DEFAULT_RC=FALSE
fi

# }}}
# {{{   PATH Settings
# -----------------------------------------------------

# Setting the $PATH
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games"

if [[ -d $DIR_SCRIPTS ]]; then
    PATH=$PATH:$DIR_SCRIPTS
fi

if [[ -d $HOME/bin ]]; then
    PATH=$PATH:$HOME/bin
fi

if [[ -d $HOME/.gem/ruby/2.2.0/bin ]]; then
    PATH=$PATH:$HOME/.gem/ruby/2.2.0/bin
fi

# }}}
# {{{   Vi mode for Zsh
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

# }}}
# {{{   Colors for functions
# -----------------------------------------------------

COLOR_DEFAULT=$(tput sgr0)
COLOR_TITLE=$(tput setaf 7; tput bold)
COLOR_HL1=$(tput setaf 4; tput bold)

# }}}
# {{{   Basic command hacks
# -----------------------------------------------------

# Always verbose core commands
for command in cp rm mv mkdir chmod chown rename; do
    alias $command="$command -v"
done

# History grep
hist() {
    if [[ "$1" != "" ]]; then
        fc -l 1 | grep "$1"
    else
        fc -l 1
    fi
}

# Create a backup copy in the current directory
cpbak() { for files in "$@"; do cp $files $files.bak; done }
# Create a backup copy in the Backup dir
cpbakdir() { for files in "$@"; do cp $files $DIR_BACKUP; done }

# Copy filename to clipboard, copy filepath to clipboard
copyname() { echo -n $1 | xsel -b }
copypath() { realpath $1 | xsel -b }

# List and grep, usage: lsgrep <keyword>
lsgrep() {
	keyword=$(echo "$@" |  sed 's/ /.*/g')
	ls -la | grep -iE --color=auto $keyword
}

# Man and grep. Usage: mangrep <command name> <keyword>
mangrep() { man $1 | grep --color=auto $2 }

# Colored man pages (https://wiki.archlinux.org/index.php/Man_page#Using_less_.28Recommended.29)
# LESS_TERMCAP_so's last number is the highlight color (e.g.:3m is yellow, or 33m is blue)
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;3m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}
# }}}
# {{{   Compton
# -----------------------------------------------------

# Set urxvt's transparency in compton's config
compton-opacity() {
    compton_config=~/.config/compton/compton.conf
    if [[ -e  $compton_config ]]; then
        if [[ -z $1 ]]; then
            VALUE=$(awk 'NR==4' $HOME/.config/compton/compton.conf)
            echo "Error! Opacity value cannot be empty. You need to set a number."
            echo "The current setting is: $VALUE"
        else
            # change the opacity value in the 4th line
            sed -i "4s/[0-9][0-9]/$1/" $compton_config
            echo -e "$COLOR_HL1::$COLOR_TITLE urxvt transparency in compton.conf has been set to:$COLOR_HL1 $1 $COLOR_DEFAULT"
            echo -e "$COLOR_HL1::$COLOR_TITLE Restart compton? (y = yes) $COLOR_DEFAULT"
            read compton_restart
            if [[ $compton_restart == "y" ]] || [[ $compton_restart == "Y" ]]; then
                pkill compton &&
                sleep 1s &&
                compton -b --config $compton_config &&
                echo "Compton restart: done!"
            fi
        fi
    else
        echo -e "$COLOR_HL1::$COLOR_TITLE Error! $compton_config doesn't exist. $COLOR_DEFAULT"
    fi
}

# Hint for compton opacity
hint-compton() {
    echo -e "$COLOR_HL1::$COLOR_TITLE hint-compton >$COLOR_DEFAULT the current opacity-rule in compton.conf:"
    awk 'NR==4' $HOME/.config/compton/compton.conf
}

# }}}
# {{{   Mediaplayer / Radio
# -----------------------------------------------------

# mpv: list watch later dir's content and select from them
if [[ -x $DIR_SCRIPTS/mpv-watch-later.sh ]]; then
    alias mpv-watch-later='$DIR_SCRIPTS/mpv-watch-later.sh'
fi

# Online radios
radio-classfm() { $MEDIAPLAYER "http://icast.connectmedia.hu/4784/live.mp3" }
radio-radio1() { $MEDIAPLAYER "http://stream.radio1pecs.hu:8200/pecs.mp3" }
radio-mr2petofi() { $MEDIAPLAYER "http://109.199.58.90/4738/mr2.mp3" }
radio-rockradio-60s() { $MEDIAPLAYER "http://listen.rockradio.com/public1/60srock.pls" }
radio-rockradio-80s() { $MEDIAPLAYER "http://listen.rockradio.com/public1/80srock.pls" }
radio-rockradio-90s() { $MEDIAPLAYER "http://listen.rockradio.com/public1/90srock.pls" }
radio-rockradio-bluesrock() { $MEDIAPLAYER "http://listen.rockradio.com/public1/bluesrock.pls" }
radio-rockradio-classicrock() { $MEDIAPLAYER "http://listen.rockradio.com/public1/classicrock.pls" }
radio-rockradio-poprock() { $MEDIAPLAYER "http://listen.rockradio.com/public1/poprock.pls" }

radioplayer() {

    # Define radios
    radio1="http://stream.radio1pecs.hu:8200/pecs.mp3"
    classfm="http://icast.connectmedia.hu/4784/live.mp3"
    mr2petofi="http://109.199.58.90/4738/mr2.mp3"

    # Check if mpv is installed
    if [[ ! -x /bin/mpv ]]; then
        echo '>>> Error: mpv is not installed. Please install mpv first.<<<'
        exit
    fi

    # Play
    mpv --quiet $radio1 &
    echo -e '                  _ _             _                       '
    echo -e '                 | (_)           | |                      '
    echo -e '    ____ ____  __| |_  ___  ____ | | ____ _   _  ___ ____ '
    echo -e '   |  __/ _  |/ _` | |/ _ \|  _ \| |/ _  | | | |/ _ \  __|'
    echo -e '   | | | (_| | (_| | | (_) | |_) | | (_| | |_| |  __/ |   '
    echo -e '   |_|  \____|\____|_|\___/| ___/|_|\____|\___ |\___|_|   '
    echo -e '                           | |             __/ |          '
    echo -e '                           |_|            |___/           '
    echo "$(tput setaf 4;tput bold)>>> Playing: Radio 1 <<<$(tput sgr0)"
    echo "$(tput setaf 4;tput bold)>>> To switch channel, press a number (1-3) and hit Enter <<<$(tput sgr0)"
    while true
        do
            read switch_to
            if [[ $switch_to == "2" ]]; then
                pkill mpv
                echo -e '                  _ _             _                       '
                echo -e '                 | (_)           | |                      '
                echo -e '    ____ ____  __| |_  ___  ____ | | ____ _   _  ___ ____ '
                echo -e '   |  __/ _  |/ _` | |/ _ \|  _ \| |/ _  | | | |/ _ \  __|'
                echo -e '   | | | (_| | (_| | | (_) | |_) | | (_| | |_| |  __/ |   '
                echo -e '   |_|  \____|\____|_|\___/| ___/|_|\____|\___ |\___|_|   '
                echo -e '                           | |             __/ |          '
                echo -e '                           |_|            |___/           '
                echo "$(tput setaf 4;tput bold)>>> Switching to channel: Class FM <<<$(tput sgr0)"
                mpv --quiet $classfm &
            elif [[ $switch_to == "3" ]]; then
                pkill mpv
                echo -e '                  _ _             _                       '
                echo -e '                 | (_)           | |                      '
                echo -e '    ____ ____  __| |_  ___  ____ | | ____ _   _  ___ ____ '
                echo -e '   |  __/ _  |/ _` | |/ _ \|  _ \| |/ _  | | | |/ _ \  __|'
                echo -e '   | | | (_| | (_| | | (_) | |_) | | (_| | |_| |  __/ |   '
                echo -e '   |_|  \____|\____|_|\___/| ___/|_|\____|\___ |\___|_|   '
                echo -e '                           | |             __/ |          '
                echo -e '                           |_|            |___/           '
echo "$(tput setaf 4;tput bold)>>> Switching to channel: mr2 Petofi <<<$(tput sgr0)"
                mpv --quiet $mr2petofi &
            elif [[ $switch_to == "1" ]]; then
                pkill mpv
                echo -e '                  _ _             _                       '
                echo -e '                 | (_)           | |                      '
                echo -e '    ____ ____  __| |_  ___  ____ | | ____ _   _  ___ ____ '
                echo -e '   |  __/ _  |/ _` | |/ _ \|  _ \| |/ _  | | | |/ _ \  __|'
                echo -e '   | | | (_| | (_| | | (_) | |_) | | (_| | |_| |  __/ |   '
                echo -e '   |_|  \____|\____|_|\___/| ___/|_|\____|\___ |\___|_|   '
                echo -e '                           | |             __/ |          '
                echo -e '                           |_|            |___/           '
echo "$(tput setaf 4;tput bold)>>> Switching to channel: Radio1 <<<$(tput sgr0)"
                mpv --quiet $radio1 &
            elif [[ $switch_to == "q" ]]; then
                pkill mpv
            fi
        done
}

# }}}
# {{{   Config Files
# -----------------------------------------------------

# Edit config files
alias cfg-awesome='$EDITOR ~/.config/awesome/rc.lua'
alias cfg-bashrc='$EDITOR ~/.bashrc'
alias cfg-compton='$EDITOR ~/.config/compton/compton.conf'
alias cfg-dircolors='$EDITOR ~/.dircolors'
alias cfg-dirbookmarks='$EDITOR ~/.dirbookmarks'
alias cfg-firefox='$EDITOR ~/.config/firefox/user.js'
alias cfg-fstab='sudo $EDITOR /etc/fstab'
alias cfg-grub='sudo $EDITOR /etc/default/grub'
alias cfg-hosts='sudo $EDITOR /etc/hosts'
alias cfg-muttrc='$EDITOR ~/.mutt/muttrc'
alias cfg-pacman='sudo $EDITOR /etc/pacman.conf'
alias cfg-pacmirror='sudo $EDITOR /etc/pacman.d/mirrorlist'
alias cfg-ranger='$EDITOR ~/.config/ranger/rc.conf'
alias cfg-ranger-rifle='$EDITOR ~/.config/ranger/rifle.conf'
alias cfg-rtorrent='$EDITOR ~/.rtorrent.rc'
alias cfg-vimrc='$EDITOR ~/.vimrc'
alias cfg-vimrc-root='sudo $EDITOR /root/.vimrc'
alias cfg-vimperatorrc='$EDITOR ~/.vimperatorrc'
alias cfg-xinitrc='$EDITOR ~/.xinitrc'
alias cfg-xresources='$EDITOR ~/.Xresources'
alias cfg-zshrc='$EDITOR ~/.zshrc'

# Reload config files
alias rld-bashrc='source ~/.bashrc'
alias rld-gpg='echo RELOADAGENT | gpg-connect-agent'
alias rld-xresources='xrdb -load ~/.Xresources && echo "reload .Xresources: done!"'
alias rld-zshrc='source ~/.zshrc'
alias RR='rld-zshrc'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
rld-compton() { pkill compton && sleep 1s && compton -b --config ~/.config/compton/compton.conf ; }

# To-do list
if [[ -f $HOME/Documents/TODO.todo ]]; then
    alias todo='$EDITOR $HOME/Documents/TODO.todo'
fi

# }}}
# {{{   Pacman
# -----------------------------------------------------

# pacman: aliases
alias pacins='sudo pacman -S' # install
alias pacinsu='sudo pacman -U' # istall local pkg
alias pacss='pacman -Ss' # search in remote packages
alias pacqs='pacman -Qs' # search in installed packages
alias pacsync='sudo pacman -Syy' # update repo lists
alias pacupd='sudo pacman -Syyu' # update & upgrade
alias pacupg='sudo pacman -Syyu' # update & upgrade
alias paclsup='sudo pacman -Syy && pacman -Qu' # show availabe updates
alias paclspkg='pacman -Q' # list installed packages
alias paclsaur='pacman -Qmq' #list AUR and manually installed packages
alias paclsaurpkg='pacman -Qm' # list installed AUR packages
alias cdpacpkg='cd /var/cache/pacman/pkg' # change to pacman cache dir
alias cdyaourtpkg='cd /var/cache/pacman/pkg-yaourt' # change to yaourt cache dir

#pacman: show package info
pacinfo() {
    if [[ -z $@ ]]; then
        echo "Error! No package name was given."
    else
        pacman -Qi $@
    fi
}

# pacman: show package dependencies
pacdep() { pacman -Qi "$@" | grep Depends }

# pacman: show size of the package
pacsize() { pacman -Qi "$@" | grep Size }

# pacman: size of the cache dir
paccachesize() { du -hs /var/cache/pacman }

# pacman: list or search in cache
pacpkg() {

    cache_dir=/var/cache/pacman/pkg
    cache_dir_yaourt=/var/cache/pacman/pkg-yaourt

    # fi $1 is empty, then just list all the packages
    if [[ $1 == "" ]]; then
    echo "--------------------------------------------------------------------------"
    echo -e "$COLOR_HL1::$COLOR_TITLE pacpkg >$COLOR_DEFAULT Listing $cache_dir:"
        ls -l $cache_dir
    echo "--------------------------------------------------------------------------"
        if [[ -d $cache_dir_yaourt ]]; then
            echo -e "$COLOR_HL1::$COLOR_TITLE pacpkg >$COLOR_DEFAULT Listing $cache_dir_yaourt:"
            ls -l $cache_dir_yaourt
            echo "--------------------------------------------------------------------------"
        fi
    # if $1 is NOT empty, then it's a search
    else
    echo "--------------------------------------------------------------------------"
    echo -e "$COLOR_HL1::$COLOR_TITLE pacpkg >$COLOR_DEFAULT Search results for $1 in $cache_dir:"
        ls -l $cache_dir | grep $1

        if [[ -d $cache_dir_yaourt ]]; then
            echo "--------------------------------------------------------------------------"
            echo -e "$COLOR_HL1::$COLOR_TITLE pacpkg >$COLOR_DEFAULT Search results for $1 in $cache_dir_yaourt:"
            ls -l $cache_dir_yaourt | grep $1
            echo "--------------------------------------------------------------------------"
        fi
    fi
}

# pacman: removed orphaned
pacrmo() {
    echo -e "$COLOR_HL1::$COLOR_TITLE sudo pacman -Rns \$(pacman -Qdtq) $COLOR_DEFAULT:: Remove all orphaned packages, their configuration files and unneeded dependecies.\n"
    sudo pacman -Rns $(pacman -Qdtq)
}

# pacman: remove packages
pacrm() {
    echo -e "$COLOR_HL1::$COLOR_TITLE sudo pacman -Rns $COLOR_DEFAULT:: Remove packages, their configuration files and unneeded dependecies.\n"
    sudo pacman -Rns "$@"
}

# pacman: change to the new mirrorlist
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

# pacman: log
# Based on: https://bbs.archlinux.org/viewtopic.php?pid=1281605#p1281605
paclog(){
	LOGFILE="/var/log/pacman.log"
	case "$1" in
		-h)	# Show help
		    echo "paclog"
            echo "Usage: paclog [-option]"
            echo ""
            echo "\033[1;34m      -i\033[0m                Show log entries for installed."
            echo "\033[1;34m      -r\033[0m                Show log entries for removed."
            echo "\033[1;34m      -u\033[0m                Show log entries for upgraded."
            echo "\033[1;34m      -d\033[0m                Show log entries for downgraded."
            echo "\033[1;34m      -m\033[0m                Show log entries for messages."
            echo "\033[1;34m      -s <keyword>\033[0m      Search for <keyword> in the log entries."
            echo "\033[1;34m      -h\033[0m                This help."
            echo ""
            echo "Without an option, the \033[1;34mpaclog\033[0m command shows the entire log."
		    ;;
		-i) # Show installed
			grep 'installed' $LOGFILE | grep -v 'ALPM-SCRIPTLET' | less
		    ;;
		-r) # Show removed
			grep 'removed' $LOGFILE | grep -v 'ALPM-SCRIPTLET' | less
		    ;;
		-u) # Show upgraded
			grep 'upgraded' $LOGFILE | grep -v 'ALPM-SCRIPTLET' | less
		    ;;
        -d) # Show downgraded
            grep 'downgraded' $LOGFILE | grep -v 'ALPM-SCRIPTLET' | less
		    ;;
        -s) # Search in log
			grep $2 $LOGFILE | less
		    ;;
		-m) # Show messages
			grep 'ALPM-SCRIPTLET' -B 1 $LOGFILE | less
			;;
		*)  # Show the entire log
		    less $LOGFILE
		esac
}

# locate pac* files
# https://wiki.archlinux.org/index.php/Pacnew_and_Pacsave_files#Locating_.pac.2A_files
pacfilesfinder() {
    echo -e "$COLOR_HL1::$COLOR_TITLE pacfilesfinder >$COLOR_DEFAULT Listing pac* files in /etc:"
    find /etc -regextype posix-extended -regex ".+\.pac(new|save|orig)" 2> /dev/null
}

# pacman: last upgrade date/time
# source: https://bbs.archlinux.org/viewtopic.php?pid=1345525#p1345525
paclastupg() { awk '/upgraded/ {line=$0;} END { $0=line; gsub(/[\[\]]/,"",$0); printf "\033[1;34mPacman > Last Upgraded:\033[0m %s %s\n",$1,$2; exit;}' /var/log/pacman.log }

# show hints/reminders for my pacman alises and functions
hint-pacman() {
    echo "--------------------------------------------------------------------------"
    echo -e "$COLOR_HL1::$COLOR_TITLE hint-pacman >$COLOR_DEFAULT Listing pacman aliases:"
    lsmyalias | grep --color=never pac | grep -v 'lsmyalias' | grep -v 'echo'
    echo "--------------------------------------------------------------------------"
    echo -e "$COLOR_HL1::$COLOR_TITLE hint-pacman >$COLOR_DEFAULT Listing pacman functions:"
    lsmyfunc | grep --color=never -E "^pac"
    echo "--------------------------------------------------------------------------"
}

# }}}
# {{{   Void / xbps
# -----------------------------------------------------

# services
sv-status() {
    if [[ ! -z $1 ]]; then
        sudo sv status $1
    else
        sudo sv status /var/service/*
    fi
}
sv-stop() { sudo sv down $1 }
sv-start() { sudo sv up $1 }
sv-restart() { sudo sv restart $1 }
sv-enable() { sudo ln -s /etc/sv/$1 /var/service/ }
sv-disable() { sudo rm /var/service/$1 }
sv-list() { ls -l /etc/sv }

#xbps
xbps-pkglist() { xbps-query -l | awk '{print $2;}' | sed 's/-[0-9].*//' }
xbps-pkglistver() { xbps-query -l | awk '{print $2;}' }
xbps-pkgcount() { xbps-query -l | wc -l }
xbps-pkgsize() { xbps-query "$1" | grep --color=never "size" }
xbps-pkgver() { xbps-query --property=pkgver "$1" }
xbps-pkgdep() { xbps-query -x "$1" }

# }}}
# {{{ Git
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
    echo -e "$COLOR_HL1::$COLOR_TITLE Checking:$COLOR_HL1 $DIR_SCRIPTS $COLOR_DEFAULT"
    git -C $DIR_SCRIPTS status
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
alias grm='git rm --cached' # Removes remote file copy only. (eg.: removing ignored files that are already pushed without removing the local copies)
alias cdgit='cd ~/git'

# gitfile.sh, download single file from Github (https://github.com/spcmd/Scripts/blob/master/gitfile.sh)
# using with gitfile.js vimperator plugin (https://github.com/spcmd/dotfiles/blob/master/vimperator/.vimperator/plugin/gitfile.js)
if [[ -x $DIR_SCRIPTS/gitfile.sh ]]; then
    alias gitfile='$DIR_SCRIPTS/gitfile.sh'
fi

# Copy updated site content generated by jekyll to the site directory under git
if [[ -x $DIR_SCRIPTS/gitsiteup.sh ]]; then
    alias gitsiteup='$DIR_SCRIPTS/gitsiteup.sh'
fi

# copy preview images to img directories
gitprevimg() {
    for images in "$@"; do
       cp $images ~/.xampp/spcmd/img
       cp $images ~/.xampp/spcmd/_site/img
       cp $images ~/git/spcmd.github.io/img
   done
}

# }}}
# {{{ awesome WM related
# -----------------------------------------------------

# mailchecker switch
awm-chkmail-off() {
    echo 'off' > $HOME/.config/awesome/mailchecker &&
    echo 'awm checkmail has been set to OFF' &&
    echo 'mail_widget_timer:connect_signal("timeout",mail_status)' | awesome-client
}
awm-chkmail-on() {
    echo 'on' > $HOME/.config/awesome/mailchecker &&
    echo 'awm checkmail has been set to ON' &&
    echo 'mail_widget_timer:connect_signal("timeout",mail_status)' | awesome-client
}

# note file for using with awesome WM widget
# widget format should be the same as in awesome rc.lua
awm-note() {

    NOTE_FILE=$HOME/Documents/awm-note.txt

    if [[ ! -e $NOTE_FILE ]]; then
        touch $NOTE_FILE
        echo "Note file created at $NOTE_FILE"
    fi

    case "$1" in

        # Listing notes
        -l) cat $NOTE_FILE
            ;;
        # Delete line from notes
        -r) sed -i ${2}d $NOTE_FILE
            echo "removed line $2 from $NOTE_FILE"
            ;;
        # Delete ALL notes (delete the file)
        -R)
            echo "Delete ALL notes? [yY/nN]"
            read answer
            if [[ $answer == "y" ]] || [[ $answer == "Y" ]]; then
                #echo -n > $NOTE_FILE
                rm $NOTE_FILE
                echo 'note_widget:set_text("")' | awesome-client
                echo "All notes was deleted."
            else
                echo "Cancelled. Nothing changed."
            fi
            ;;
        # Help
        ""|-h) echo "Usage: awm-note [OPTIONS]"
            echo -e "\nTo add a note, use:"
            echo -e "\t awm-note \"your note in qoutes\""
            echo -e "\nOptions:"
            echo -e "-l\t\t list notes"
            echo -e "-r [number]\t delete note (by line number)"
            echo -e "-R \t\t delete ALL notes (delete the file)"
            echo -e "-h\t\t this help"
            ;;
        # Add note
        *)  echo "$1" >> $NOTE_FILE
            echo "added '$1' to $NOTE_FILE"
            echo 'note_widget:set_markup(" <span font_weight=\"bold\" color=\"red\">notes</span>")' | awesome-client
            ;;
    esac

}


# }}}
# {{{ Note
note() {

    FILE_NOTES=~/.notes

    case "$1" in

        -r|--remove)
                        sed -i "/$2/d" $FILE_NOTES
                        ;;
        -R|--remove-all)
                        echo "Remove ALL notes? Are you sure [yY/nN]"
                        read answer
                        if [[ $answer == "y" ]] || [[ $answer == "Y" ]]; then
                            cp $FILE_NOTES /tmp
                            rm $FILE_NOTES
                            echo "$FILE_NOTES has been deleted. Now you can find a copy in /tmp (for emergency) until the next reboot. Delete manually if you wish."
                        else
                            echo "Cancelled."
                        fi
                        ;;
        -l|--list)
                        tac $FILE_NOTES
                        ;;

        -L|--list-oldest-first)
                        cat $FILE_NOTES
                        ;;
        -s|--search)
                        grep -i "$2" $FILE_NOTES
                        ;;
        -S|--search-case-sensitive)
                        grep "$2" $FILE_NOTES
                        ;;
        -h|--help)
cat <<EOF
Usage: note [option] <note|keyword>

    <note>                                      Add a note (you can add a note without using the -a or the --all option)
    -a, --add <note>                            Add a note
    -r, --remove <keyword>                      Remove note(s) by keyword (a keyword can be any word, tag, date or time)
    -R, --remove-all                            Remove ALL notes (emergency backup will be created in /tmp)
    -l, --list                                  List notes (show newer first)
    -L, --list-oldest-first                     List notes (show oldest first)
    -s, --search <keyword>                      Search in the notes (case-insensitive)
    -S, --search-case-sensitive <keyword>       Search in the notes (case-sensitive)
    -h, --help                                  This help

Important: Use quoting for the notes! Use @ for tagging, e.g.:

    note "This is my first note @mytag"         This will add a note with the tag @mytag
    note -r "13:22"                             This will remove note(s) with the 13:22 timestamp
    note -r "@mytag"                            This will remove note(s) with the tag @mytag

EOF
                        ;;
        -a|--add)
                        echo "$(date +"[%Y-%b-%d %H:%M]") $2" >> $FILE_NOTES
                        ;;
        *)
                        echo "$(date +"[%Y-%b-%d %H:%M]") $1" >> $FILE_NOTES
                        ;;
    esac
}
# }}}
# {{{ Net utils / Web service related
# -----------------------------------------------------

# is this site down?
isdown() { curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g;s/&#x2F;/\//g' }

# what is my ip?
myip()  { curl -s curl -s http://whatismyip.akamai.com | grep -o "[[:digit:].]\+" }

# url shortener
urlshort() { wget -qO - "http://is.gd/create.php?format=simple&url=$1" }

# imgur (Bart's Bash Script Uploader, http://imgur.com/tools )
if [[ -x $DIR_SCRIPTS/imgur-upload.sh ]]; then
    alias imgur='$DIR_SCRIPTS/imgur-upload.sh'
fi

# bbtv.sh (https://github.com/spcmd/Scripts/blob/master/bbtv.sh)
if [[ -x $DIR_SCRIPTS/bbtv.sh ]]; then
    alias bbtv='$DIR_SCRIPTS/bbtv.sh'
fi

# translate shell (google translate) (https://github.com/soimort/translate-shell)
gthu() { trans :hu "$@" }
gten() { trans hu:en "$@" }
alias trans-update='wget -N -P ~/Scripts https://raw.githubusercontent.com/soimort/translate-shell/gh-pages/trans'

# speedtest-cli (https://github.com/sivel/speedtest-cli | https://aur.archlinux.org/packages/speedtest-cli)
if [[ -x /bin/speedtest-cli ]]; then
    speedtest(){
        case "$1" in
            -h)	# Show help
                echo "Speedtest (a wrapper for speedtest-cli)"
                echo "Usage: speedtest [-option]"
                echo ""
                echo "\033[1;34m         -l\033[0m Show hungarian servers."
                echo "\033[1;34m         -a\033[0m Show All servers."
                echo "\033[1;34m         -s <number>\033[0m Connect to a server with a number from the listed servers."
                echo "\033[1;34m         -h\033[0m This help."
                echo ""
                echo "Without an option, the \033[1;34mspeedtest\033[0m command connects to server 3715 (DIGI)"
                echo "For full feature, use the \033[1;34mspeedtest-cli \033[0mcommand, see \033[1;34mspeedtest-cli -h \033[0mfor help. "
                ;;
            -l) # Show hungarian servers
                speedtest-cli --list | grep "Hungary"
                ;;
            -a) # Show All servers
                speedtest-cli --list
                ;;
            -s) # Connect to a sever
                speedtest-cli --server $2
                ;;
            *)  # Connect to DIGI server
                speedtest-cli --server 3715
            esac
    }
fi

# }}}
# {{{   Trashman: use trash from CLI (https://aur.archlinux.org/packages/trashman/)
# -----------------------------------------------------

# trashman: list
TL() {
    echo -e "$COLOR_HL1::$COLOR_TITLE trashman >$COLOR_DEFAULT Listing Trash:"
    trash --list
}

# trashman: put
TP() {
    trash $@
    echo -e "$COLOR_HL1::$COLOR_TITLE trashman >$COLOR_DEFAULT Files have been put to Trash:"
    printf '%s\n' "$@"
}

# trashman: restore
TR() {
    echo -e "$COLOR_HL1::$COLOR_TITLE trashman >$COLOR_DEFAULT Restore file from Trash:"
    trash --list
    echo -e "$COLOR_HL1::$COLOR_TITLE trashman >$COLOR_DEFAULT To restore file(s), use the command: trash -r filename1 filename2 ..."
    cd ~/.local/share/Trash/files
}

# trashman: empty
TE() {
    echo -e "$COLOR_HL1::$COLOR_TITLE trashman >$COLOR_DEFAULT Emptying Trash, are you sure? (y = yes)"
    read answer_trash
    if [[ $answer_trash == "y" ]] || [[ $answer_trash == "Y" ]]; then
        trash --empty
        echo -e "$COLOR_HL1::$COLOR_TITLE trashman >$COLOR_DEFAULT Done! Trash is empty."
    else
        echo -e "$COLOR_HL1::$COLOR_TITLE trashman >$COLOR_DEFAULT Exit. Trash hasn't been emptied."
    fi
}

# }}}
# {{{   Dirbookmarks: mark directories & quick change dir from CLI (Based on: https://bbs.archlinux.org/viewtopic.php?pid=1318927#p1318927)
# -----------------------------------------------------

dirbookmarks() {
    case "$1" in
            -h|*)# Show help
                echo "dirbookmarks are stored in ~/.dirbookmarks"
                echo "Commands:"
                echo ""
                echo "\033[1;34m         markdir <bookmarkname>                                 \033[0m Add current directory to bookmarks with name <bookmarkname>"
                echo "\033[1;34m         unmarkdir <bookmarkname> [anotherbookmarkname...]      \033[0m Remove <bookmarkname> from bookmarks. You can specify multiple names in one command."
                echo "\033[1;34m         lsmarks                                                \033[0m List bookmarked directories."
                echo "\033[1;34m         cdm <bookmarkname>                                     \033[0m Change to bookmarked directory."
                ;;
    esac
}

markdir() {
    if [[ ! -z $1 ]] && [[ $1 != "-h" ]]; then
        echo "$1|$(pwd)" >> $HOME/.dirbookmarks
    elif [[ $1 = "-h" ]]; then
        dirbookmarks # show help
    else
        echo "markdir Error: you have to name the bookmark! Usage:\033[1;34m markdir <bookmarkname>\033[0m"
    fi
}

unmarkdir() {
    if [[ ! -z $1 ]] && [[ $1 != "-h" ]]; then
        for marks in $@; do
            sed -i "/^$marks|/d" $HOME/.dirbookmarks
        done
    elif [[ $1 = "-h" ]]; then
        dirbookmarks # show help
    else
        echo -e "unmarkdir Error: you have to specify a bookmark name which you want to delete! Usage: \033[1;34munmarkdir <bookmarkname> [anotherbookmarkname...]\033[0m \nFor listing, use the \033[1;34mlsmarks \033[0mcommand."
    fi
}

lsmarks() {
    echo -e "Listing directories saved to .dirbookmarks:\n"
    awk -F "|" -v OFS="\033[0;36m ---> \033[0m" ' $1="\t\033[1;34m"$1 '  $HOME/.dirbookmarks
}

cdm() {
	dir=$(grep $1 $HOME/.dirbookmarks)
	dir=${dir/*|/}
	cd $dir
}

# completion is zsh only!
function _completemarks {
	reply=($(sed 's/\(.*\)|.*/\1/' $HOME/.dirbookmarks))
}
compctl -K _completemarks cdm
compctl -K _completemarks unmarkdir

# }}}
# {{{  Other Aliases and Functions
# -----------------------------------------------------

alias q=' exit' # do not store the command in the history
alias ls='ls --color=auto -A'
alias lsl='ls -Alh --group-directories-first --color=auto'
alias lf='ls -lA1p $@ | grep -v "\/$"' # list files only
alias free='free -h'
alias lsblkf='lsblk -o "NAME,SIZE,MOUNTPOINT,RO,FSTYPE,LABEL,UUID"'
alias dist-info='cat /etc/*-release'
alias dist-name='cat /etc/*-release | grep -E "^NAME" | cut -c 6-'
alias grep='grep --color'

alias hdapm='sudo hdparm -I /dev/sda | grep level'
alias jekyllserve='cd ~/.xampp/spcmd && echo "Serving: $(pwd)" && jekyll serve -w'
alias ytdla='youtube-dl --extract-audio --audio-format="mp3" --audio-quality=0 -o "~/Downloads/%(title)s.%(ext)s"'
alias ytdl='youtube-dl -f "best[height=720]" -o "~/Downloads/%(title)s.%(ext)s"'
alias gifview='gifview -aU' #gifsicle gifview: animated and unoptimized by default
alias sshx='ssh -X -C -c blowfish-cbc,arcfour' # SSH with X (to run GUI apps)
alias lscon='nmcli con show'
alias pingg='ping google.com'
alias kpass='kpcli --kdb'
alias cpw='xsel -c && xsel -bc && echo "Clipboard cleared."'
alias mutt1='mutt -F ~/.mutt/account.1.muttrc'
alias mutt2='mutt -F ~/.mutt/account.2.muttrc'
alias re-nm='sudo systemctl restart NetworkManager'
alias lampp-start='sudo /opt/lampp/lampp start'
alias lampp-stop='sudo /opt/lampp/lampp stop'
alias lampp-restart='sudo /opt/lampp/lampp restart'
alias zzz='systemctl suspend'
alias sss='systemctl poweroff'

# Load ISO to loop device and mount (for Games)
iso-load() {
    if [[ -z $1 ]]; then
        echo "Error: no ISO file specified."
        echo "Usage:"
        echo -e "\t iso-load /path/to/file.iso"
    else
        udisksctl loop-setup -r -f $1 && sudo mount /dev/loop0 /media/ISO
    fi
}
# Unmount and unload ISO
iso-unload() { sudo umount /media/ISO && udisksctl loop-delete -b /dev/loop0 }

# Send mail using mutt cli
mailthis() {
    message=$1
    subject=$2
    to=$3
    if [[ -z $message || -z $subject || -z $to ]]; then
        echo "Error! You have to specify MESSAGE SUBJECT TO"
        echo "For example:"
        echo "mailthis \"This is a my message\" \"Subject\" somebody@domain.com"
    else
        echo "$message" | mutt -F ~/.mutt/account.1.muttrc -s "$subject" "$to"
    fi
}


# vless (use vim as a pager)
vless() { vim -u $HOME/.vimlessrc $1 }

# stopwatch
stopwatch() {
    date1=$(date +%s)
    while true; do
       echo -ne "$(date -u --date @$(($(date +%s) - $date1)) +%H:%M:%S)\r";
    done
}

# calculator
calc() {
    echo "Python calc (exit with Ctrl+D)"
    python2 -ic "from __future__ import division; from math import *; from random import *"
}

# Rsync to external Backup HDD
if [[ -x /bin/rsync ]]; then
    rsync-Documents() {
        RACK_BACKUP_DIR='/media/320GB_Rack/00Backup_spcmd/'
        if [[ -d $RACK_BACKUP_DIR ]]; then
            rsync -avr $HOME/Documents/ $RACK_BACKUP_DIR/Documents/
        else
            echo "rsync-Documents Error! \033[1;34m$RACK_BACKUP_DIR \033[0mnot found. Is it mounted? Or has the directory changed?"
        fi
    }
fi

# Hint for watching dd progress
hint-dd() {
    echo -e "$COLOR_HL1::$COLOR_TITLE hint-dd >$COLOR_DEFAULT Use this command to watch the progress of the dd command:"
    echo -e "\tdd bs=4M count=5 if=/dev/random of=/dev/null & pid=\$! ; watch -n 3 kill -USR1 \$pid"
}

# List all custom function and alias names from this .zshrc
lsmyfunc() {cat ~/.zshrc | cut -d "{" -f 1 | sed "s/ //g" | grep "()"}
lsmyalias() {cat ~/.zshrc | cut -d "{" -f 1 | sed -e "s/^[ \t]*//" | grep -v "^#" | grep alias}

# APT
if [[ -x /usr/bin/apt-get ]]; then
    apt-update() { sudo apt-get update && notify-send -i terminal "Update finished!" }
    apt-upgrade() { sudo apt-get upgrade && notify-send -i terminal "Upgrade finished!" }
    apt-install() { sudo apt-get install --no-install-recommends $@ && notify-send -i terminal "Finished installing $@" }
    alias apt-remove='sudo apt-get remove --purge'
    alias apt-ppa='sudo add-apt-repository'
fi

# }}}


