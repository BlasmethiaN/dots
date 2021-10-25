#!/usr/bin/env bash

function mkcd() {
  mkdir "$1" 
  cd "$1"
}

connect() {
    bluetoothctl power on
    bluetoothctl connect $1
}

niceboi() {
    connect 3A:99:83:31:E2:9A
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
