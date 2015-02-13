set -g  XDG_CONFIG_HOME $HOME/.config
set -g  XDG_CACHE_HOME $HOME/.cache
set -g  XDG_DATA_HOME $HOME/.local/share

set -gx EDITOR vim
set -gx SUDO_EDITOR vim
set -gx BROWSER "chromium"
set -gx JAVA_HOME /usr/lib/jvm/java-default-runtime
set -gx LC_ALL en_US.UTF-8 # Fucking Ruby

if test ruby
	set -gx PATH /home/tim/.gem/ruby/2.2.0/bin $PATH
end


set fish_custom $HOME/.config/fish

set -g VIRTUALFISH_COMPAT_ALIASES
. $fish_custom/plugins/virtualfish/virtual.fish
. $fish_custom/plugins/virtualfish/auto_activation.fish
. $fish_custom/plugins/virtualfish/global_requirements.fish
. $fish_custom/plugins/virtualfish/projects.fish

test -s /home/tim/.nvm-fish/nvm.fish; and source /home/tim/.nvm-fish/nvm.fish

if test go
	mkdir -p ~/go
	set -gx GOPATH ~/go
	set -gx PATH ~/go/bin $PATH
end

# Aliases
alias startx='ssh-agent startx'
alias gnome-terminal='gnome-terminal --hide-menubar'
