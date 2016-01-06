set -g  XDG_CONFIG_HOME $HOME/.config
set -g  XDG_CACHE_HOME $HOME/.cache
set -g  XDG_DATA_HOME $HOME/.local/share

set -gx EDITOR vim
set -gx SUDO_EDITOR vim
set -gx BROWSER "chromium"
set -gx JAVA_HOME /usr/lib/jvm/java-default-runtime
set -gx LC_ALL en_US.UTF-8 # Fucking Ruby

set -gx PATH /usr/local/bin/ $PATH

if test ruby
	set -gx PATH /home/tim/.gem/ruby/2.3.0/bin $PATH
end

if test go
	mkdir -p ~/go
	set -gx GOPATH ~/go
	set -gx PATH ~/go/bin $PATH
end

### Aliases

alias startx='ssh-agent startx'
alias gnome-terminal='gnome-terminal --hide-menubar'
alias idea='intellij-idea-ultimate-edition'


### Plugins

set fish_custom $HOME/.config/fish

source ~/projects/dotfiles/config/fish/plugins/nvm/nvm.fish 
eval (python -m virtualfish auto_activation global_requirements)
