# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler

set fish_plugins archlinux django extract python pyenv tmux vundle

# Path to your custom folder (default path is $FISH/custom)
set fish_custom $HOME/.config/fish/custom

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

. $fish_custom/plugins/virtualfish/virtual.fish
. $fish_custom/plugins/virtualfish/auto_activation.fish
. $fish_custom/plugins/virtualfish/global_requirements.fish
. $fish_custom/plugins/virtualfish/projects.fish

test -s /home/tim/.nvm-fish/nvm.fish; and source /home/tim/.nvm-fish/nvm.fish
