#!/usr/bin/env bash

function mkcd() {
  mkdir -p "$1" 
  cd "$1"
}

connect() {
    bluetoothctl power on
    bluetoothctl connect $1
}

niceboi() {
    connect 3A:99:83:31:E2:9A
}

soundcore() {
    connect AC:12:2F:E1:5F:D4
}

function schedule() {
  feh ~/Data/Pics/schedule.png
}

function cwd() { 
  pwd | tr -d '\n' | xclip -selection clipboard 
}

function ngap() {
  echo 'require("awful").screen.focused().selected_tag.gap = 0' | awesome-client 
}

function agap() {
  echo 'require("awful").screen.focused().selected_tag.gap = 6' | awesome-client 
}

function ass() {
 nasm -f elf32 -g -o "$1".o "$1".asm
 gcc -m32 -o "$1" "$1".o 
}

function wcyd() {
  echo 'What can you do.' 
  $(mpv ~/Data/Memes/Sounds/wcyd.wav &>/dev/null & disown)
}

function based() {
  echo "Ring ring, it's for You, it's the based police."
  $(mpv ~/Data/Memes/Sounds/basedpolice.wav &>/dev/null & disown)
}
