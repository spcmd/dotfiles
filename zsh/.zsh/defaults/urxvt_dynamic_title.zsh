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
    #
        # fix title when switching to shell from ranger, then back to ranger (q is aliased to exit)
        # note: this might cause a screen refresh (flashing) in the terminal window after executing commands!
        [[ $1 = "q" ]] && name="ranger" || name="$1"

        # set the name
        printf "\033]0;%s\a" "$name"
    }

  ;;
esac

