# https://www.webpro.nl/articles/getting-started-with-dotfiles
# Create a new directory and enter it
function mk() {
  mkdir -p "$@" && cd "$@" || exit
}

function bun_turbo() {
  bunx --bun turbo "$1" --log-order=grouped --parallel
}
