# https://www.webpro.nl/articles/getting-started-with-dotfiles
export EDITOR="code"
export VISUAL="code"

# XDG Base Directory Specification (https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
export XDG_HOME_DIR="$HOME"
export ZPFX="$XDG_HOME_DIR/.local"
export XDG_CACHE_HOME="$XDG_HOME_DIR/.cache"
export XDG_CONFIG_HOME="$XDG_HOME_DIR/.config"
export XDG_DATA_HOME="$ZPFX/share"
export XDG_STATE_HOME="$ZPFX/state"

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Highlight section titles in man pages
export LESS_TERMCAP_md=$'\e[1;36m'

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto';

# Configure brew
export HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS=1
export HOMEBREW_BAT=1
export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

# Configure rust
source "$HOME/.cargo/env"
