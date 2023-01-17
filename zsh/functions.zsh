# https://www.webpro.nl/articles/getting-started-with-dotfiles
# Create a new directory and enter it
function mk() {
  mkdir -p "$@" && cd "$@"
}
