# dotfiles

My dotfiles, set up using [Dotbot](https://github.com/anishathalye/dotbot).

## Other things you'll need to do

1. Set zsh as default shell: `chsh -s /bin/zsh`.
1. Install [Homebrew](https://brew.sh/).
1. Clone repo - `git clone https://github.com/lishaduck/dotfiles.git && cd dotfiles`
1. Run the bootstrapper - `./install`.

## Idempotence

Once you've made updates, run `./install` to reinstall everything.
You can safely run this as many times you want,
and it shouldn't need any intervention, i.e., there're no `sudo` prompts.
