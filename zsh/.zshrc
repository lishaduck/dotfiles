# You may need to manually set your language environment
export LANG=en_US.UTF-8

# for pyzshcomplete (I'm running PR 59 so I don't need sudo)
fpath+="${HOME}/.local/pipx/venvs/pyzshcomplete/lib/python3.10/site-packages/pyzshcomplete/zsh_scripts"
fpath+="${HOME}/.zfunc"

path=(
  $path
  "."
  "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" # vscode
  "${HOME}/.local/bin" # pipx
  "${HOME}/.local/share/pnpm" # pnpm
  "${HOME}/.venv/stars/" # starship
  "${HOME}/.venv/.cargo/bin" # cargo
  "${HOME}/.venv/roc_nightly/" # roc
  "${HOME}/.venv/flutter/bin" # Flutter
  "${HOME}/.venv/lamdera" # Lamdera
  "${HOME}/.venv/github" # `gh` cli
  "${HOME}/.pub-cache/bin" # Dart
  )

# Rust
export CARGO_HOME="${HOME}/.venv/.cargo/"
export RUSTUP_HOME="${HOME}/.venv/.config/rustup/"

# Flutter
export FLUTTER_ROOT="${HOME}/.venv/flutter"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/dukese01/.dart-cli-completion/zsh-config.zsh ]] && . /Users/dukese01/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]


# Completions
export ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST-$ZSH_VERSION"
autoload -Uz compinit bashcompinit
compinit -d $ZSH_COMPDUMP
bashcompinit

# Export nvm completion settings for zsh-nvm plugin
export NVM_DIR="${HOME}/.nvm"
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="code"
  export VISUAL="code"
fi


# Set personal aliases
# For a full list of active aliases, run `alias`.
source "${HOME}/aliases.zsh"
source "${HOME}/functions.zsh"

eval "$(register-python-argcomplete pytest)"

# pnpm
export PNPM_HOME="${HOME}/.local/share/pnpm"
# pnpm end

# ZMods
zmodload -a colors
zmodload -a autocomplete
zmodload -a complist

# Globbing
setopt extended_glob
setopt dot_glob

# Completions
## Fuzzy
zstyle ":completion:*" completer _complete _match _approximate
zstyle ":completion:*:match:*" original only
zstyle -e ":completion:*:approximate:*" max-errors "reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)"
## Pretty
zstyle ":completion:*:matches" group "yes"
zstyle ":completion:*:options" description "yes"
zstyle ":completion:*:options" auto-description "%d"
zstyle ":completion:*:corrections" format " %F{green}-- %d (errors: %e) --%f"
zstyle ":completion:*:descriptions" format " %F{yellow}-- %d --%f"
zstyle ":completion:*:messages" format " %F{purple} -- %d --%f"
zstyle ":completion:*:warnings" format " %F{red}-- no matches found --%f"
zstyle ":completion:*:default" list-prompt "%S%M matches%s"
zstyle ":completion:*" format " %F{yellow}-- %d --%f"
zstyle ":completion:*" group-name ""
zstyle ":completion:*" verbose yes
zstyle ":completion:*" matcher-list "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=*" "l:|=* r:|=*"
zstyle ":completion:*:functions" ignored-patterns "(_*|pre(cmd|exec))"
zstyle ":completion:*" use-cache true
zstyle ":completion:*" rehash true
## Menu
zstyle ":completion:*" menu yes select
## Colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Zi's recommended "history optimization" techniques
setopt append_history         # Allow multiple sessions to append to one Zsh command history.
setopt extended_history       # Show timestamp in history.
setopt hist_expire_dups_first # Expire A duplicate event first when trimming history.
setopt hist_find_no_dups      # Do not display a previously found event.
setopt hist_ignore_all_dups   # Remove older duplicate entries from history.
setopt hist_ignore_dups       # Do not record an event that was just recorded again.
setopt hist_ignore_space      # Do not record an Event Starting With A Space.
setopt hist_reduce_blanks     # Remove superfluous blanks from history items.
setopt hist_save_no_dups      # Do not write a duplicate event to the history file.
setopt hist_verify            # Do not execute immediately upon history expansion.
setopt inc_append_history     # Write to the history file immediately, not when the shell exits.
setopt share_history          # Share history between different instances of the shell.

# Zi's recommended tweaks
setopt auto_cd              # Use cd by typing directory name if it's not a command.
setopt auto_list            # Automatically list choices on ambiguous completion.
setopt auto_pushd           # Make cd push the old directory onto the directory stack.
setopt bang_hist            # Treat the '!' character, especially during Expansion.
setopt interactive_comments # Comments even in interactive shells.
setopt multios              # Implicit tees or cats when multiple redirections are attempted.
setopt prompt_subst         # Substitution of parameters inside the prompt each time the prompt is drawn.
setopt pushd_ignore_dups    # Don't push multiple copies directory onto the directory stack.


# Zi

## Load Zi
if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "${HOME}/.zi" && command chmod go-rwX "${HOME}/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "${HOME}/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "${HOME}/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
# examples here -> https://wiki.zshell.dev/ecosystem/category/-annexes
# zicompinit # <- https://wiki.zshell.dev/docs/guides/commands

## Install Zi plugins from OMZ
zi snippet OMZP::git
zi snippet OMZP::macos        # requires copying in spotify and music files manually
# zi snippet OMZP::poetry     # broken without $ZSH_CACHE_DIR
zi snippet OMZP::python
zi snippet OMZP::pylint
zi snippet OMZP::swiftpm
zi snippet OMZP::safe-paste
zi snippet OMZP::man
zi snippet OMZP::aliases
zi snippet OMZP::alias-finder
zi snippet OMZP::virtualenv
zi snippet OMZP::web-search
zi snippet OMZP::xcode
# zi snippet OMZP::octozen      # took to long, broke vscode

## Install Zi plugins from OMZ (custom)
# zi load jameshgrn/zshnotes    # broken on mac
zi load lukechilds/zsh-nvm
zi load lukechilds/zsh-better-npm-completion
zi load MichaelAquilina/zsh-you-should-use

## Install Zi Annexes
zi light-mode for z-shell/z-a-meta-plugins @annexes @z-shell @ext-git @zsh-users+fast

## It asked me to
source "${HOME}/.zi/plugins/tj---git-extras/etc/git-extras-completion.zsh"

# my theme
eval "$(starship init zsh)"

function set_win_title(){
    echo -ne "\033]0; $(basename "${PWD}") \007"
}
precmd_functions+=(set_win_title)
