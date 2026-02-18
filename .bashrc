#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Created by `pipx` on 2026-02-13 05:07:38
export PATH="$PATH:/home/ahron/.local/bin"

####  Animated Neofetch Splash
if [[ -n $PS1 ]]; then
   ~/.config/fastfetch/animated-fastfetch.sh 0.05
fi
