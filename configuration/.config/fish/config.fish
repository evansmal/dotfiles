# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

alias mcss-r "$HOME/Projects/mcss-docker/scripts/run"
alias mcss-x "$HOME/Projects/mcss-docker/scripts/exec"

alias conf-display-work "$HOME/.screenlayout/work.sh"

alias gc "git checkout"
alias gs "git status"
alias gd "git diff"
alias ga "git add"
alias gap "git add -p"

fish_vi_key_bindings

# opam configuration
source /home/evan/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
