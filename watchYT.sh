#!/bin/bash
# watch youtube video in VLC or MPC
URL=$(kdialog --inputbox "enter URL")
CHOICE=$(kdialog --radiolist "Choose a mode:" \
  vlc "Stream via VLC" off \
  mpv "Stream via MPV" on \
  awrit "Stream via awrit" off \
  download "Download video" off)

case $CHOICE in
vlc)
  yt-dlp -o - "$URL" | vlc -
  ;;
mpv)
  yt-dlp -o - "$URL" | mpv -
  ;;
awrit)
  awrit "$URL"
  kitty --hold -e ~/awrit/awrit "$URL"
  ;;
download)
  yt-dlp "$URL"
  ;;
esac
