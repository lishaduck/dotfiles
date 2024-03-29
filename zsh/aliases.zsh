# https://opensource.com/article/19/7/bash-aliases
alias lt='du -sh \* | sort -h';
alias count='find . -type f | wc -l';

# https://www.webpro.nl/articles/getting-started-with-dotfiles
# Recursively remove .DS_Store files
alias cleanupds="find . -type f -name '\*.DS_Store' -ls -delete";

# Alias to make safe force-pushing easier
alias gforce='git push --force-with-lease';

# Alias to launch chrome from terminal
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome';

# Aliases for 'eza'
alias _eza_base='eza --classify --hyperlink --header --group-directories-first -I .git --icons --git --git-ignore --no-permissions'
alias eza_long='_eza_base --long --all --dereference --total-size'
alias eza_tree='_eza_base --tree --almost-all --git';

# Aliases for brew
alias brewgraph='brew graph --installed --highlight-leaves | fdp -T png -o graph.png'

# Aliases for Flutter
alias clean_flutter='dart run build_runner clean && flutter clean'
alias fresh_flutter='clean_flutter && flutter upgrade && flutter pub get --precompile && flutter run'

# Remove some aliases for git
unalias gk
unalias grv

# Navigation aliases
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"
