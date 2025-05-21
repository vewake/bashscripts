#!/bin/bash
# script to open clipboard content in neovim
if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
  clip_content=$(wl-paste)
else
  echo "Unsupported display server"
  exit 1
fi

temp_file="/tmp/clip_$(date +%s).txt"
echo "$clip_content" >"$temp_file"

kitty --hold -e nvim "$temp_file"
