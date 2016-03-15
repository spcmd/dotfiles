autoload -U colors && colors
setopt auto_cd          # Change dir without the cd command
setopt multios          # Perform implicit tees or cats when multiple redirections are attempted
setopt cdablevars       # Try to expand the expression as if it were preceded by a ‘~’
setopt prompt_subst     # Needed for prompt coloring (expasion)
unsetopt nomatch        # Globbing
