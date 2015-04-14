# This file is sourced only for login shells (i.e. shells
# invoked with "-" as the first character of argv[0], and
# shells invoked with the -l flag.)
#
# Global Order: zshenv, zprofile, zshrc, zlogin 

# Auto startx
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
