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

set -x EDITOR "vim"
set -x BROWSER "chromium"
set -x CHROMIUM_USER_FLAGS "--disk-cache-size=/tmp/cache --disk-cache-size=50000000 --disable-gl-error-limit"
set -x _JAVA_AWT_WM_NONREPARENTING 1

. ~/.config/fish/virtual.fish

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
