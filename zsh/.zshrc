# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Zinit
source $HOMEBREW_PREFIX/opt/zinit/zinit.zsh
# examples here -> https://github.com/zdharma-continuum/zinit/wiki/Recipes-for-popular-programs

if type brew &>/dev/null; then
  zinit add-fpath "$HOMEBREW_PREFIX/share/zsh/site-functions"
fi

# Install Zinit annexes.
zinit lucid for zdharma-continuum/z-a-meta-plugins \
  "@annexes" \
  skip'zdharma-continuum/zsh-diff-so-fancy' "@zdharma" \
  skip'zdharma-continuum/zconvey' "@zdharma2"

# Use one-dark theme for eza and completions.
zinit wait lucid reset id-as'ls-colors' for \
  atclone'echo "export LS_COLORS=\"$(vivid generate one-dark)\"" >! clrs.zsh' \
  atpull'%atclone' pick'clrs.zsh' nocompile'''!' \
  atload'zstyle ":completion:*:default" list-colors "${(s.:.)LS_COLORS}"' \
  pick'clrs.zsh' \
  nocompile \
    @zdharma-continuum/null

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f $XDG_CONFIG_HOME/.dart-cli-completion/zsh-config.zsh ]] && . $XDG_CONFIG_HOME/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

# Oils
OILS_HIJACK_SHEBANG=osh

# Bun
export BUN_INSTALL="$HOME/.bun"

# Deno
export DENO_FUTURE=1

# Update path
path=(
  $HOMEBREW_PREFIX/opt/ruby/bin # ruby
  $path
  "." # current directory
  "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" # vscode
  $CARGO_HOME/bin # cargo
  $HOME/.pub-cache/bin # Dart
  $HOME/Library/Android/sdk/cmake/3.22.1/bin # CMake
  $HOME/Library/Android/sdk/sdk/cmdline-tools/latest/bin # Android
  $HOME/Library/Android/sdk/platform-tools # More Android
  $HOME/.deno/bin # deno
  $BUN_INSTALL/bin # bun
  $HOMEBREW_PREFIX/opt/python@3.12/libexec/bin # python
  $HOMEBREW_PREFIX/lib/python3.12/site-packages # python
  )

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
setopt hist_expire_dups_first # Expire A duplicate event first when trimming history.
setopt hist_find_no_dups      # Do not display a previously found event.
setopt hist_ignore_all_dups   # Remove older duplicate entries from history.
setopt hist_ignore_dups       # Do not record an event that was just recorded again.
setopt hist_ignore_space      # Do not record an Event Starting With A Space.
setopt hist_reduce_blanks     # Remove superfluous blanks from history items.
setopt hist_save_no_dups      # Do not write a duplicate event to the history file.
setopt hist_verify            # Do not execute immediately upon history expansion.
setopt share_history          # Write to the history file immediately, not when the shell exits.

# Zinit's recommended tweaks
setopt auto_cd              # Use cd by typing directory name if it's not a command.
setopt auto_list            # Automatically list choices on ambiguous completion.
setopt auto_pushd           # Make cd push the old directory onto the directory stack.
setopt bang_hist            # Treat the '!' character, especially during Expansion.
setopt interactive_comments # Comments even in interactive shells.
setopt multios              # Implicit tees or cats when multiple redirections are attempted.
setopt prompt_subst         # Substitution of parameters inside the prompt each time the prompt is drawn.
setopt pushd_ignore_dups    # Don't push multiple copies directory onto the directory stack.

# Functions
autoload -Uz zmv
autoload -Uz zcalc

# More Zinit managed installations.
## Install shell plugins
### plugins from OMZ
zinit lucid for \
  OMZL::git.zsh \
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
  # OMZP::macos # requires copying in spotify and music files manually

## Install zsweep
zinit wait lucid for \
  sbin'bin/zsweep' @psprint/zsh-sweep

## Install Roc
zinit wait lucid from'gh-r' nocompile'' for \
  as'program' \
  extract'!-' \
  pick'roc' \
    @roc-lang/roc

## Install Lamdera
zinit wait lucid for id-as'lamdera' \
  as'program' \
  dl'https://static.lamdera.com/bin/lamdera-1.2.1-macos-arm64 -> lamdera' \
  pick'lamdera' \
  nocompile'' \
    @zdharma-continuum/null

## Install Pnpm shell completions
zinit wait lucid for \
  atload"zpcdreplay" \
  atclone"./zplug.zsh" \
  atpull"%atclone" \
    @g-plane/pnpm-shell-completion

## Hook direnv into zsh
zinit lucid id-as'direnv/loader' for \
  atclone'direnv hook zsh > init.zsh' \
  atpull'%atclone' \
  nocompile'' \
    @zdharma-continuum/null

## Get completions for autodoc2, and poetry
zinit lucid id-as'completions/ext' as'completion' for \
  atclone'poetry completions zsh > _poetry \
    && autodoc2 --show-completion > _autodoc2' \
  atpull'%atclone' \
  nocompile'' \
    @zdharma-continuum/null

## GH Copilot
zinit lucid id-as'ghcopilot/loader' for \
  atclone'gh copilot alias -- zsh > init.zsh' \
  atpull'%atclone' \
  nocompile'' \
    @zdharma-continuum/null

## Set personal aliases
### For a full list of active aliases, run `alias`.
source ~/aliases.zsh
source ~/functions.zsh

if [[ $TERM_PROGRAM != "WarpTerminal" ]] && [[ $TERMINAL_EMULATOR != "JetBrains-JediTerm" ]]; then
##### WHAT YOU WANT TO DISABLE FOR WARP - BELOW
    # Remind me of my aliases
    export YSU_IGNORED_ALIASES=("zi" "zplg" "zpl" "zini") # Ignore zplug and zi aliases
    zinit wait lucid for \
        "@MichaelAquilina/zsh-you-should-use"

    # Use zsh-users tools
    zinit lucid for \
        "@hlissner/zsh-autopair" \
        "@zsh-users+fast"

    # Use starship prompt
    zinit lucid id-as'starship/loader' for \
      atclone'starship init zsh --print-full-init > init.zsh' \
      atpull'%atclone' \
      nocompile'' \
        @zdharma-continuum/null

    # Use please as terminal "new tab page"
    zinit lucid id-as'please/loader' for \
      atclone'please --show-completion zsh > _please' \
      atpull'%atclone' \
      atload'please' \
      nocompile'' \
        @zdharma-continuum/null

##### WHAT YOU WANT TO DISABLE FOR WARP - ABOVE
fi

### Nvm Config
export NVM_COMPLETION=true
#export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true
zinit lucid for \
    @MichaelAquilina/zsh-autoswitch-virtualenv \
  atclone'nvm install --lts' atpull'%atclone' \
    @lukechilds/zsh-nvm

# GPG Verification
zinit wait lucid id-as'gpg' for \
  atinit'export GPG_TTY=$(tty)' \
  nocompile \
    @zdharma-continuum/null
