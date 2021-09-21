#
# ~/.bashrc
#

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

eval "$(starship init bash)"

shopt -s expand_aliases

alias ls='exa --long --color=auto'
alias config="git --git-dir=$HOME/.dots/ --work-tree=$HOME"
alias  vim='nvim'
alias battery='bat /sys/class/power_supply/BAT1/capacity'
alias schedule='feh ~/Data/Pics/schedule.png'

export VISUAL="nvim"
export EDITOR="$VISUAL"

[[ -f ~/.bash_functions ]] && . ~/.bash_functions

