autoload -U compinit promptinit
compinit
promptinit

setopt completealiases
setopt inc_append_history
setopt share_history

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.history

bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[4~" end-of-line # End
bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history # PageDown
bindkey "\e[2~" quoted-insert # Ins
bindkey "\e[3~" delete-char # Del
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[Z" reverse-menu-complete # Shift+Tab
# for rxvt
bindkey "\e[7~" beginning-of-line # Home
bindkey "\e[8~" end-of-line # End
# for non RH/Debian xterm, can't hurt for RH/Debian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
# for guake
bindkey "\eOF" end-of-line
bindkey "\eOH" beginning-of-line
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "\e[3~" delete-char # Del

# This will set the default prompt to the walters theme
prompt clint

export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH="/usr/lib/colorgcc/bin:$PATH"
export CCACHE_PATH="/usr/bin"
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a functionEDITOR="vim"
export LESS="-R"

export JYTHON_HOME=~/Work/txtr/txtr_skins/libs/jython-dev
export TXTR_BIN=$JYTHON_HOME/bin
export PATH=$TXTR_BIN:$PATH

CP="$JYTHON_HOME/jython.jar"
if [ ! -f $CP ]; then
    echo "Error : $JYTHON_HOME/jython.jar is not available"
    exit 1
fi
if [ ! -z "$CLASSPATH" ]; then CP=$CP:$CLASSPATH; fi

alias pacman="pacman-color"
alias grep='grep --color=auto'
alias ls='ls -hF --color=auto'
alias ping='ping -c 5'
eval $(dircolors -b)

POST_UP="su -c 'DISPLAY=:0 /usr/bin/dropboxd &' tim"
PRE_DOWN="killall dropbox"

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end

