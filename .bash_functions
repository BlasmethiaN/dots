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

function botanoha() {
  echo "Vždycky jsem měl vysoké vysoké naděje na žití."
  echo "Střílel jsem na hvězdy když jsem nemohl dělat zabíjení."
  echo "Neměl jsem deseticent, ale vždycky jsem měl vizi."
  echo "Vždycky jsem měl vysoké vysoké naděje."

  $(mpv ~/Data/Memes/Sounds/hrabeleg.wav &>/dev/null & disown)
}

function broken() {
  echo "The world is broken."
  echo "We’re the last choking embers of a fire waiting to burn out."
  echo "Long before our grandfathers and their fathers before them,"
  echo "we started pulling our planet apart in the name of progress and blind ambition."
  echo "The greed of man has devoured this earth until there was nothing left."
  echo "We watch as time eats us alive. A generation born to witness the end of the world."

  $(mpv ~/Data/Memes/Sounds/broken.wav &>/dev/null & disown)
}

function hurts() {
  echo "It hurts. ❤️ 🔥"
  $(mpv ~/Data/Memes/Sounds/hurts.wav &>/dev/null & disown)
}

function nya() {
  echo "Nya 🥵🐱"
  $(mpv ~/Data/Memes/Sounds/nya.wav &>/dev/null & disown)
}
