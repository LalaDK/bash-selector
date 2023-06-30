#! /usr/bin/env bash

function setup() {
  WIDTH=$(tput cols)
  HEIGHT=$(tput lines)
  CENTER_X=$(( WIDTH / 2 ))
  CENTER_Y=$(( LINES / 2 ))
  LINE_WIDTH=30
}

function read_char() {
  escape_char=$(printf "\u1b")
  read -rsn1 mode # get 1 character
  if [[ $mode == $escape_char ]]; then
        read -rsn2 mode # read 2 more chars
  fi
  case $mode in
    'q') echo QUITTING ; exit ;;
    '[A') echo UP ;;
    '[B') echo DN ;;
    '[D') echo LEFT ;;
    '[C') echo RIGHT ;;
      *) >&2 echo 'ERR bad input'; return ;;
  esac
}

function line() {
  LEFT_CHAR=${1:-'+'}
  PAD_CHAR=${2:-'-'}
  RIGHT_CHAR=${3:-'+'}
  printf -- "$LEFT_CHAR";
  printf -- "$PAD_CHAR%.0s" $(seq 1 $LINE_WIDTH);
  printf -- "$RIGHT_CHAR"
}
function line_text() {
  LEFT_CHAR=${1:-'+'}
  RIGHT_CHAR=${3:-'+'}
  
  printf -- "$LEFT_CHAR";
  [ ${4:-''} = 'highlight' ] && tput rev
  printf -- "%-${LINE_WIDTH}s" $2;
  [ ${4:-''} = 'highlight' ] && tput sgr0
  printf -- "$RIGHT_CHAR"
}

setup
line '\u2554' '\u2550' '\u2557'
echo
line "\u2551" 'x' '\u2551'
echo
line_text "\u2551" "Hello" '\u2551' highlight
echo
line "\u255a" '\u2550' '\u255d'
echo
