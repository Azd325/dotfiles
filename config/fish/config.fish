set -g  XDG_CONFIG_HOME $HOME/.config
set -g  XDG_CACHE_HOME $HOME/.cache
set -g  XDG_DATA_HOME $HOME/.local/share

set -gx EDITOR vim
set -gx SUDO_EDITOR vim
set -gx BROWSER "chromium"
set -gx JAVA_HOME /usr/lib/jvm/java-default-runtime




set fish_custom $HOME/.config/fish/

set -g VIRTUALFISH_COMPAT_ALIASES
. $fish_custom/plugins/virtualfish/virtual.fish
. $fish_custom/plugins/virtualfish/auto_activation.fish
. $fish_custom/plugins/virtualfish/global_requirements.fish
. $fish_custom/plugins/virtualfish/projects.fish

test -s /home/tim/.nvm-fish/nvm.fish; and source /home/tim/.nvm-fish/nvm.fish

alias startx='ssh-agent startx'
