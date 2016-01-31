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

export EDITOR="vim"

# don't put duplicate lines or lines starting with space in the history
HISTCONTROL="ignoreboth"

# don't put these commands in the history
HISTIGNORE="history:clear"

# append to the history file, don't overwrite it
shopt -s histappend

# history length (lines & files size)
HISTSIZE=1000
HISTFILESIZE=2000
