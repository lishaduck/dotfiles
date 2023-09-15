# https://www.webpro.nl/articles/getting-started-with-dotfiles
export EDITOR="code"
export VISUAL="code"

# XDG Base Directory Specification (https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)

export XDG_CACHE_HOME="$HOME/.venv/.cache"
export XDG_CONFIG_HOME="$HOME/.venv/.config"
export XDG_DATA_HOME="$HOME/.venv/.local/share"
export XDG_STATE_HOME="$HOME/.venv/.local/state"

# History

export HISTSIZE=32768
export HISTFILESIZE="${HISTSIZE}"
export SAVEHIST=4096
export HISTCONTROL=ignoredups:erasedups

# Enable colors
export CLICOLOR=1

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Highlight section titles in man pages
export LESS_TERMCAP_md="${yellow}"

# Keep showing man page after exit
export MANPAGER="less -X"

# Tell grep to highlight matches
# export GREP_OPTIONS='-color=auto';
