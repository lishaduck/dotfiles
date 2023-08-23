# You may need to manually set your language environment
export LANG="en_US.UTF-8";
fpath+="${HOME}/.zfunc";

# Zi

## Load Zi
if [[ ! -f $HOME/.venv/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f";
  command mkdir -p "${HOME}/.venv/.zi" && command chmod go-rwX "${HOME}/.venv/.zi";
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "${HOME}/.venv/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b";
fi
typeset -Ag ZI
typeset -gx ZI[HOME_DIR]="${HOME}/.venv/.zi" ZI[BIN_DIR]="${ZI[HOME_DIR]}/bin"
source "${HOME}/.venv/.zi/bin/zi.zsh";
autoload -Uz _zi;
(( ${+_comps} )) && _comps[zi]=_zi;
# examples here -> https://wiki.zshell.dev/ecosystem/category/-annexes

## Install Zi Annexes
zi light-mode for z-shell/z-a-meta-plugins \
  "@annexes" \
  "@z-shell" \
  "@ext-git" \
  "@zsh-users+fast" \
  "@sharkdp" \

zi pack for \
  atclone'nb notebooks add https://github.com/lishaduck/notes' nb \
  pack'bgn' pyenv \
  ls_colors \

# zi rustup for \
#   z-shell/0

# Rust
export CARGO_HOME="${ZPFX}/bin/rust/.cargo";
export RUSTUP_HOME="${ZPFX}/bin/rust/rustup";

path=(
  $path
  "."
  "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" # vscode
  "${HOME}/.local/bin" # pipx
  "${CARGO_HOME}/bin" # cargo
  "${HOME}/development/flutter/bin" # Flutter
  "${HOME}/.pub-cache/bin" # Dart
   $HOME/.gradle/wrapper/dists/gradle-8.*-bin/*/gradle-8.*/bin # Gradle
  )

# Flutter
# export FLUTTER_ROOT="${HOME}/.venv/flutter";

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f ~/.dart-cli-completion/zsh-config.zsh ]] && . ~/.dart-cli-completion/zsh-config.zsh || true;
## [/Completion]

# Completions
export ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST-$ZSH_VERSION";
autoload -Uz compinit bashcompinit;
compinit -d "${ZSH_COMPDUMP}" && bashcompinit;

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim";
else
  export EDITOR="code";
  export VISUAL="code";
fi

# Set personal aliases
# For a full list of active aliases, run `alias`.
source "${HOME}/aliases.zsh";
source "${HOME}/functions.zsh";

# ZMods
zmodload -a colors;
zmodload -a autocomplete;
zmodload -a complist;

# Globbing
setopt extended_glob;
setopt dot_glob;

# Completions
## Fuzzy
zstyle ":completion:*" completer _complete _match _approximate;
zstyle ":completion:*:match:*" original only;
zstyle -e ":completion:*:approximate:*" max-errors "reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)";
## Pretty
zstyle ":completion:*:matches" group "yes";
zstyle ":completion:*:options" description "yes";
zstyle ":completion:*:options" auto-description "%d";
zstyle ":completion:*:corrections" format " %F{green}-- %d (errors: %e) --%f";
zstyle ":completion:*:descriptions" format " %F{yellow}-- %d --%f";
zstyle ":completion:*:messages" format " %F{purple} -- %d --%f";
zstyle ":completion:*:warnings" format " %F{red}-- no matches found --%f";
zstyle ":completion:*:default" list-prompt "%S%M matches%s";
zstyle ":completion:*" format " %F{yellow}-- %d --%f";
zstyle ":completion:*" group-name "";
zstyle ":completion:*" verbose yes;
zstyle ":completion:*" matcher-list "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=*" "l:|=* r:|=*";
zstyle ":completion:*:functions" ignored-patterns "(_*|pre(cmd|exec))";
zstyle ":completion:*" use-cache true;
zstyle ":completion:*" rehash true;
## Menu
zstyle ":completion:*" menu yes select;
## Colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}";

# Zi's recommended "history optimization" techniques
setopt append_history;         # Allow multiple sessions to append to one Zsh command history.
setopt extended_history;       # Show timestamp in history.
setopt hist_expire_dups_first; # Expire A duplicate event first when trimming history.
setopt hist_find_no_dups;      # Do not display a previously found event.
setopt hist_ignore_all_dups;   # Remove older duplicate entries from history.
setopt hist_ignore_dups;       # Do not record an event that was just recorded again.
setopt hist_ignore_space;      # Do not record an Event Starting With A Space.
setopt hist_reduce_blanks;     # Remove superfluous blanks from history items.
setopt hist_save_no_dups;      # Do not write a duplicate event to the history file.
setopt hist_verify;            # Do not execute immediately upon history expansion.
setopt inc_append_history;     # Write to the history file immediately, not when the shell exits.
setopt share_history;          # Share history between different instances of the shell.

# Zi's recommended tweaks
setopt auto_cd;              # Use cd by typing directory name if it's not a command.
setopt auto_list;            # Automatically list choices on ambiguous completion.
setopt auto_pushd;           # Make cd push the old directory onto the directory stack.
setopt bang_hist;            # Treat the '!' character, especially during Expansion.
setopt interactive_comments; # Comments even in interactive shells.
setopt multios;              # Implicit tees or cats when multiple redirections are attempted.
setopt prompt_subst;         # Substitution of parameters inside the prompt each time the prompt is drawn.
setopt pushd_ignore_dups;    # Don't push multiple copies directory onto the directory stack.

# Zi managed installations.

## Install Zi plugins from OMZ
zi for \
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
  # OMZP::macos \      # requires copying in spotify and music files manually
  # OMZP::poetry \     # broken without $ZSH_CACHE_DIR
  # OMZP::octozen \    # didn't work w/out wifi

## Install Zi plugins from OMZ (custom)
zi wait lucid for MichaelAquilina/zsh-you-should-use


# GIT stands for 'Github Issue Tracker', the future name of the project
GIT_PROJECTS="PSDTools/app:PSDTools/PHS-Map:PSDTools/GPA_Calculator"

zi service"GIT" pick"zsh-github-issues.service.zsh" wait'2' lucid for \
  z-shell/zsh-github-issues

## Install Direnv
zi from'gh-r' as'program' mv'direnv* -> direnv' \
  atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
  pick'direnv' src='zhook.zsh' for \
    direnv/direnv

## Install Appwrite, Docker, and Roc
zi wait lucid as'program' from'gh-r' for \
  mv'appwrite-cli* -> appwrite' appwrite/sdk-for-cli \
  mv'docker* -> docker-compose' docker/compose \
  pick'gh*/bin/gh' cli/cli \
  \
  nocompile \
  bpick'*macos_x86_64-latest*' \
  extract \
  mv'roc*/roc -> roc' \
  pick'roc' \
    roc-lang/roc \

## Install Lamdera
zi wait lucid as'program' for \
  pick'lamdera' dl'static.lamdera.com/bin/lamdera-1.1.0-macos-x86_64 -> lamdera' \
    z-shell/null

## Install Pnpm
zi light-mode for id-as'pnpm' from'gh-r' bpick'*-macos-x64' as'program' \
  atinit'export PNPM_HOME=$ZPFX/bin; [[ -z $NODE_PATH ]] && \
  export NODE_PATH=$PWD' sbin'pnpm* -> pnpm' nocompile \
    pnpm/pnpm

## Install Starship
zi as'program' from'gh-r' for \
  atclone'./starship init zsh > init.zsh; ./starship completions zsh > _starship' \
  atpull'%atclone' src'init.zsh' \
    starship/starship

# Set window title for Starship.
function set_win_title(){
    echo -ne "\033]0; $(basename "${PWD}") \007";
};
precmd_functions+=(set_win_title);

# Faster completions
zicompinit_fast
zicdreplay

# Please?
please

# Source global settings.
source ~/.env
