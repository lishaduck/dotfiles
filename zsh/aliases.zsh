# https://opensource.com/article/19/7/bash-aliases
alias lt='du -sh \* | sort -h';
alias count='find . -type f | wc -l';

# https://www.webpro.nl/articles/getting-started-with-dotfiles
# Recursively remove .DS_Store files
alias cleanupds="find . -type f -name '\*.DS_Store' -ls -delete";

# Alias to make safe force-pushing easier
alias gforce='git push --force-with-lease';
