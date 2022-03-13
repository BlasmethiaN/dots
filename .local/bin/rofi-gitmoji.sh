#!/usr/bin/env bash

if [[ -v ROFI_INFO ]]; then
  echo -n "$ROFI_INFO" | xclip -selection clipboard &> /dev/null
  exit 0
fi

folder="${XDG_DATA_HOME:-"$HOME/.local/share/rofi-gitmoji"}"
filename="$folder/gitmojis.csv"

if [ ! -f "$filename" ]; then
  rofi-gitmoji-download.py "$folder"
fi

gawk '{
  match($0,/^"(.*)","(.*)"/,matches)
  print matches[1] " " matches[2] "\0info\x1f" matches[1]
}' < "$filename"
