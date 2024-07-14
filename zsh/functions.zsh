# https://www.webpro.nl/articles/getting-started-with-dotfiles
# Create a new directory and enter it
function mk() {
  mkdir -p "$@" && cd "$@" || exit
}

function check_for_dirty() {
  local dir=${1:-~/Developer/}
  find "$dir" -type d -name '.git' -execdir sh -c 'git -C {}/.. fetch > /dev/null 2>&1 && ([[ -n $(git status --porcelain) ]] || [[ -n $(git rev-list HEAD@{upstream}..HEAD) ]]) && pwd' "{}" \;
}
