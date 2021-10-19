#
# ~/.bashrc
#

include() {
  test -f "$1" && source "$@"
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

eval "$(starship init bash)"

# fuck
eval "$(thefuck --alias)"

# pat.hs
source /usr/share/paths/paths.sh

# complete alias
source /usr/share/bash-complete-alias/complete_alias

shopt -s expand_aliases

alias ls='exa --long --color=auto'
alias config="git --git-dir=$HOME/.dots/ --work-tree=$HOME"
alias vim='nvim'
alias battery='bat /sys/class/power_supply/BAT1/capacity'
alias schedule='feh ~/Data/Pics/schedule.png'
alias ccomp='cc -std=c99 -Wall -Werror -g -o'
alias cwd='pwd | tr -d "\n" | xclip -selection clipboard'
alias pl="paths list"
alias go="paths go"
alias anime="ani-cli"
complete -F _complete_alias go

export VISUAL="nvim"
export EDITOR="$VISUAL"

include ~/.bash_functions
include ~/.profile

echo
echo
neofetch
