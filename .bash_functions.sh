cwd() { 
  pwd | tr -d '\n' | xclip -selection clipboard 
}

mkcd() {
  mkdir "$1"
  cd "$1"
}

schedule() {
  feh ~/Data/Pics/schedule.png
}
