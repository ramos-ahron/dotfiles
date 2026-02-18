#!/bin/bash
delay=${1:-0.1}
ascii_row=1
ascii_col=1
text_col=60
cache_file="$HOME/.cache/fastfetch.txt"
mkdir -p ~/.cache

# Generate fastfetch output
if [[ ! -f "$cache_file" || $(find "$cache_file" -mmin +60 2>/dev/null) ]]; then
  if command -v fastfetch >/dev/null 2>&1; then
    script -q -c "fastfetch --logo none" /dev/null > "$cache_file"
  else
    neofetch --disable ascii > "$cache_file"
  fi
fi

num_lines=$(wc -l < "$cache_file")
final_row=$((ascii_row + num_lines + 1))

clear

row=$ascii_row
while IFS= read -r line; do
  tput cup $row $text_col
  printf "%s\n" "$line"
  ((row++))
done < "$cache_file"

tput civis

cleanup() {
  tput cup $final_row 0
  tput sgr0
  tput cnorm
  echo ""
  exit
}

trap cleanup INT TERM EXIT

# Animate frames
shopt -s nullglob
while true; do
  for frame in ~/.config/fastfetch/frames_colour/*.txt; do
    tput cup $ascii_row $ascii_col
    cat "$frame"
    tput sgr0 
    read -t $delay -n 1 key && cleanup
  done
done
