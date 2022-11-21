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
alias pm="pulsemixer"
alias btdc="bluetoothctl disconnect"
alias paru-r="paru -Rcns"
alias wgdv="wg-quick up Zauzoo-DVolak"
alias wgdc="wg-quick down Zauzoo-DVolak"
alias sl="sl -ad -4"
alias clip="xclip -selection clipboard"
alias gif="sxiv -a"
alias what="echo ever. 🤣😝😂😜"
alias co="echo koliv. 😂🤪🤣😝"
alias sus="systemctl suspend"
alias wamo="xsetwacom set 'Wacom Intuos S Pen stylus' MapToOutput HEAD-0"
alias inp="cd \$HOME/Data/School/INP/inp22-projekt1/ && . env/bin/activate && cd zadani/test"

complete -F _complete_alias paru-r
complete -F _complete_alias go

export VISUAL="nvim"
export EDITOR="$VISUAL"
export BAT_THEME="OneHalfDark"

include ~/.bash_functions
include ~/.profile

echo
echo
neofetch

[ -f "/home/blasmesian/.ghcup/env" ] && source "/home/blasmesian/.ghcup/env" # ghcup-env

# pnpm
export PNPM_HOME="/home/blasmesian/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
