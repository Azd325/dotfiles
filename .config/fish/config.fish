set fish_greeting ""

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'

set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set gray (set_color -o black)

set -x PATH ~/.cabal/bin $PATH
set -x PATH ~/.gem/ruby/2.0.0/bin/ $PATH
set -x PATH /opt/android-sdk/platform-tools/ $PATH
# For normal compiling https://wiki.archlinux.org/index.php/Ccache
set -x PATH /usr/lib/colorgcc/bin/ $PATH
set -x PATH /usr/bin/vendor_perl/ $PATH

set -x GOPATH "$HOME/tim/go"

set -x CCACHE_PATH /usr/bin

set -x TERM xterm-256color
set -x EDITOR vim
set -x BROWSER "google-chrome-beta"
set -x _JAVA_AWT_WM_NONREPARENTING 1

# Activate Virtualfish
# https://github.com/adambrenecki/virtualfish
if test -f ~/.config/fish/virtual.fish
    . ~/.config/fish/virtual.fish
    . ~/.config/fish/global_requirements.fish
    . ~/.config/fish/auto_activation.fish
    set -x VIRTUALFISH_HOME ~/.virtualenvs
    set -x VIRTUALFISH_COMPAT_ALIASES 1
end

# Pip settings
set -x PIP_REQUIRE_VIRTUALENV 1
set -x PIP_RESPECT_VIRTUALENV 1
set -x PIP_USE_WHEEL true
set -x PIP_WHEEL_DIR ~/.pip/wheels
set -x PIP_FIND_LINKS ~/.pip/wheels
set -x PIP_LOG_FILE ~/.cache/pip-log.txt
set -x PIP_DOWNLOAD_CACHE ~/.cache/pip


function fish_prompt
   set_color yellow
   printf '%s' (whoami)
   set_color normal
   printf ' at '

   set_color magenta
   printf '%s' (hostname|cut -d . -f 1)
   set_color normal
   printf ' in '

   set_color $fish_color_cwd
   printf '%s' (prompt_pwd)
   set_color normal

   printf '%s ' (__fish_git_prompt)
   set_color normal

   if set -q VIRTUAL_ENV
       echo -n -s (set_color cyan) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
   end
end

# start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx
    end
end


function myfunc --on-event virtualenv_did_activate
    echo "The virtualenv" (basename $VIRTUAL_ENV) "was activated"
end
