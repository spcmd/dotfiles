# -----------------------------------------------------
# Path / Dirs
# -----------------------------------------------------

# Path
fpath=($ZSH/functions $ZSH/completions $fpath)

# Plugins / Extras
if [[ -z "$ZSH_PLUGINS" ]]; then
    ZSH_CUSTOM="$ZSH/plugins"
fi

# Cache
if [[ -z "$ZSH_CACHE_DIR" ]]; then
  ZSH_CACHE_DIR="$ZSH/cache/"
fi

# My Defaults 
for config_file ($ZSH/defaults/*.zsh); do
  custom_config_file="${ZSH_CUSTOM}/defaults/${config_file:t}"
  [ -f "${custom_config_file}" ] && config_file=${custom_config_file}
  source $config_file
done

# -----------------------------------------------------
# Load stuff 
# -----------------------------------------------------

# Load all of your custom configurations from custom/
for config_file ($ZSH_PLUGINS/*.zsh(N)); do
  source $config_file
done
unset config_file

is_plugin() {
  local base_dir=$1
  local name=$2
  test -f $base_dir/plugins/$name/$name.plugin.zsh \
    || test -f $base_dir/plugins/$name/_$name
}
# Add all defined plugins to fpath. This must be done
# before running compinit.
for plugin ($plugins); do
  if is_plugin $ZSH_PLUGINS $plugin; then
    fpath=($ZSH_PLUGINS/plugins/$plugin $fpath)
  elif is_plugin $ZSH $plugin; then
    fpath=($ZSH/plugins/$plugin $fpath)
  fi
done

# Save the location of the current completion dump file.
if [ -z "$ZSH_COMPDUMP" ]; then
  ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
fi

# Load and run compinit
autoload -U compinit
compinit -i -d "${ZSH_COMPDUMP}"

# Load all of the plugins that were defined in ~/.zshrc
for plugin ($plugins); do
  if [ -f $ZSH_PLUGINS/plugins/$plugin/$plugin.plugin.zsh ]; then
    source $ZSH_PLUGINS/plugins/$plugin/$plugin.plugin.zsh
  elif [ -f $ZSH/plugins/$plugin/$plugin.plugin.zsh ]; then
    source $ZSH/plugins/$plugin/$plugin.plugin.zsh
  fi
done

# Load the theme
if [ ! "$ZSH_THEME" = ""  ]; then
  source "$ZSH/themes/$ZSH_THEME.zsh-theme"
fi
