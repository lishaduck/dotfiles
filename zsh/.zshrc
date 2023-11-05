# Zinit
ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"
declare -A ZINIT
ZINIT[NO_ALIASES]=1

## Load Zinit
if [[ ! -f $ZINIT_HOME/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}zdharma-continuum/zinit%F{160})…%f"
  command mkdir -p "$(dirname $ZINIT_HOME)"
  command git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# examples here -> https://github.com/zdharma-continuum/zinit/wiki/Recipes-for-popular-programs

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(rbenv init - zsh)"

export LDFLAGS="-L/opt/homebrew/opt/llvm@16/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm@16/include"

if type brew &>/dev/null; then
  zinit add-fpath "$HOMEBREW_PREFIX/share/zsh/site-functions"
fi

HB_CNF_HANDLER="$HOMEBREW_REPOSITORY/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
source "$HB_CNF_HANDLER";
fi

# Install stuff!
## Install zinit annexes
zinit light-mode for zdharma-continuum/z-a-meta-plugins \
  "@annexes" @zdharma-continuum/z-a-linkbin \
  "@zsh-users+fast" \
  skip'zdharma-continuum/zsh-diff-so-fancy' "@zdharma" \
  skip'zdharma-continuum/zconvey' "@zdharma2" \
  @zdharma-continuum/zinit-console

zinit wait lucid light-mode reset id-as'ls-colors' for \
  atclone"echo 'LS_COLORS=\"$(vivid generate one-dark)\"; export LS_COLORS' >! clrs.zsh" \
  atpull'%atclone' pick'clrs.zsh' nocompile'''!' \
  atload'zstyle ":completion:*:default" list-colors "${(s.:.)LS_COLORS}"' \
    @zdharma-continuum/null

# Flutter
export FLUTTER_ROOT="${HOME}/development/flutter"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f $XDG_CONFIG_HOME/.dart-cli-completion/zsh-config.zsh ]] && . $XDG_CONFIG_HOME/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

# bun
export BUN_INSTALL="$HOME/.bun"

path+=(
  "." # current directory
  "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" # vscode
  $CARGO_HOME/bin # cargo
  $FLUTTER_ROOT/bin # Flutter
  $HOME/.pub-cache/bin # Dart
  $HOME/Library/Android/sdk/cmake/3.22.1/bin # CMake
  $HOME/Library/Android/sdk/sdk/cmdline-tools/latest/bin # Android
  $HOME/Library/Android/sdk/platform-tools # More Android
  $BUN_INSTALL/bin # bun
  $HOMEBREW_PREFIX/opt/ruby/bin # ruby
  $HOMEBREW_PREFIX/opt/llvm@16/bin # llvm
  $HOMEBREW_PREFIX/opt/python@3.12/libexec/bin # python
  $HOMEBREW_PREFIX/lib/python3.12/site-packages # python
  )

# Set personal aliases
# For a full list of active aliases, run `alias`.
source "${HOME}/aliases.zsh"
source "${HOME}/functions.zsh"

# History
export HISTSIZE=32768
export HISTFILESIZE="${HISTSIZE}"
export SAVEHIST=4096
export HISTCONTROL=ignoredups:erasedups

# Enable colors
export CLICOLOR=1

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
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Zinit's recommended "history optimization" techniques
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

# Zinit's recommended tweaks
setopt auto_cd              # Use cd by typing directory name if it's not a command.
setopt auto_list            # Automatically list choices on ambiguous completion.
setopt auto_pushd           # Make cd push the old directory onto the directory stack.
setopt bang_hist            # Treat the '!' character, especially during Expansion.
setopt interactive_comments # Comments even in interactive shells.
setopt multios              # Implicit tees or cats when multiple redirections are attempted.
setopt prompt_subst         # Substitution of parameters inside the prompt each time the prompt is drawn.
setopt pushd_ignore_dups    # Don't push multiple copies directory onto the directory stack.

# Zinit managed installations.

## Install zinit plugins from OMZ
zinit lucid light-mode for \
  OMZL::git.zsh \
  atload"unalias grv" \
  OMZP::git \
  OMZP::python \
  OMZP::pylint \
  OMZP::swiftpm \
  OMZP::safe-paste \
  OMZP::man \
  OMZP::aliases \
  OMZP::alias-finder \
  OMZP::virtualenv \
  OMZP::web-search \
  OMZP::xcode \
#   OMZP::macos # requires copying in spotify and music files manually

## Nvm Config
export NVM_COMPLETION=true
# export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true


## Install zinit plugins (custom)
zinit wait lucid light-mode for \
    @MichaelAquilina/zsh-you-should-use \
    @MichaelAquilina/zsh-autoswitch-virtualenv \
  atclone'nvm install --lts' atpull'%atclone' \
    @lukechilds/zsh-nvm

## Install Roc
zinit wait lucid light-mode from'gh-r' nocompile'' for \
  as'program' \
  extract'!-' \
  pick'roc' \
    @roc-lang/roc

## Install Lamdera
zinit lucid light-mode for id-as'lamdera' \
  as'program' \
  dl'https://static.lamdera.com/bin/lamdera-1.2.1-macos-arm64 -> lamdera' \
  pick'lamdera' \
  cp'lamdera -> $ZPFX/bin/lamdera' \
  nocompile'' \
    @zdharma-continuum/null

## Install Pnpm shell completions
zinit wait lucid light-mode for \
  atload"zpcdreplay" \
  atclone"./zplug.zsh" \
  atpull"%atclone" \
    @g-plane/pnpm-shell-completion

# Hook direnv into zsh
zinit lucid light-mode id-as'direnv/loader' for \
  atclone'echo "source <(direnv hook zsh)" > init.zsh' \
  atpull'%atclone' src'init.zsh' \
  nocompile'' \
    @zdharma-continuum/null

# Use starship prompt
zinit lucid light-mode id-as'starship/loader' for \
  atclone'echo "source <(starship init zsh --print-full-init)" > init.zsh' \
  atpull'%atclone' src'init.zsh' \
  nocompile'' \
    @zdharma-continuum/null

# Get completions for autodoc2, please, and poetry
zinit lucid light-mode id-as'completions/ext' as'completion' for \
  atclone'poetry completions zsh > _poetry \
    && autodoc2 --show-completion > _autodoc2 \
    && please --show-completion zsh > _please' \
  atpull'%atclone' \
  nocompile'' \
    @zdharma-continuum/null

please # use please as terminal "new tab page"
