# Path to your custom folder (default path is $FISH/custom)
set fish_custom $HOME/.config/fish/custom

# Load oh-my-fish configuration.

. $fish_custom/plugins/virtualfish/virtual.fish
. $fish_custom/plugins/virtualfish/auto_activation.fish
. $fish_custom/plugins/virtualfish/global_requirements.fish
. $fish_custom/plugins/virtualfish/projects.fish

test -s /home/tim/.nvm-fish/nvm.fish; and source /home/tim/.nvm-fish/nvm.fish

alias startx='ssh-agent startx'
