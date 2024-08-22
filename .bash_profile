#
# ~/.bash_profile
#

source ~/.bashrc
xrandr --output HDMI-0 --primary
xrandr --output DP-1 --auto --output HDMI-0 --auto --right-of DP-1

if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.ghcup/bin" ] ; then
  PATH="$HOME/.ghcup/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ] ; then
  PATH="$HOME/.cargo/bin:$PATH"
fi

export PATH="$HOME/Data/Programs/Questa/questasim/linux_x86_64:$PATH"
export PATH="$PATH:$HOME/.dotnet/tools/"
