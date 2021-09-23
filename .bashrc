#
# ~/.bashrc
#

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

eval "$(starship init bash)"

# fuck
eval "$(thefuck --alias)"

# shellmarks
source ~/.local/bin/shellmarks.sh

shopt -s expand_aliases

alias ls='exa --long --color=auto'
alias config="git --git-dir=$HOME/.dots/ --work-tree=$HOME"
alias vim='nvim'
alias battery='bat /sys/class/power_supply/BAT1/capacity'
alias schedule='feh ~/Data/Pics/schedule.png'
alias ccomp='cc -std=c99 -Wall -Werror -g -o'
alias cwd='pwd | tr -d "\n" | xclip -selection clipboard'

export VISUAL="nvim"
export EDITOR="$VISUAL"

[[ -f ~/.bash_functions ]] && . ~/.bash_functions

echo
echo
neofetch
