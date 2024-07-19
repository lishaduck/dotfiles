# https://www.webpro.nl/articles/getting-started-with-dotfiles
# Create a new directory and enter it
function mk() {
  mkdir -p "$@" && cd "$@" || exit
}

function check_for_dirty() {
  local dir=${1:-"$HOME/Developer"}
  find "$dir" -maxdepth 2 -type d -name '.git' -execdir sh -c '
    git fetch &> /dev/null &&
    ( [[ -n $(git status --porcelain) ]] ||
      [[ -n $(git rev-list HEAD@{upstream}..HEAD) ]] ) &&
    pwd' \;
}

function check_for_gitless() {
  local dir=${1:-"$HOME/Developer"}
  find "$dir" -maxdepth 1 -type d ! -exec test -d '{}/.git' \; -print
}
