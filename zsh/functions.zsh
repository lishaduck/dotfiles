# https://www.webpro.nl/articles/getting-started-with-dotfiles
# Create a new directory and enter it
function mk() {
  mkdir -p "$@" && cd "$@" || exit
}

function check_backups() {
  local dir=${1:-"$HOME/Developer"}

  find "$dir" -mindepth 1 -maxdepth 1 -type d | while read -r subdir; do
    if [[ -d "$subdir/.git" ]]; then
      echo -e "\033[3;34m$subdir\033[0m"
      # It's a git repo
      git -C "$subdir" fetch &> /dev/null
      dirty=$(git -C "$subdir" status --porcelain)
      upstream=$(git -C "$subdir" rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
      echo -en "\033[1A"
      if [[ -n "$dirty" ]] || { [[ -n "$upstream" ]] && [[ -n $(git -C "$subdir" rev-list @{u}..HEAD 2>/dev/null) ]]; }; then
        # Bold yellow if dirty or unpushed
        echo -e "\033[1;33m$subdir $(starship module git_status --path=$subdir)\033[0m"
      else
        # Italic grey if clean
        echo -e "\033[3;90m$subdir\033[0m"
      fi
    elif [[ -d "$subdir/.jj" ]] then;
      echo -e "\033[36m$subdir (Jujutsu)\033[0m"
    else
      # Not a git repo: bold red
      echo -e "\033[1;31m$subdir (no repo)\033[0m"
    fi
  done
}
