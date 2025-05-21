# Bash Scripts

A collection of simple and useful Bash scripts I use for daily tasks on my Linux system. Most of these are tailored for Wayland and KDE, and utilize tools like `kdialog`, `adb`, `scrcpy`, and `yt-dlp`.

---

## Scripts


### `clipboardContentInNvim.sh`
Open the clipboard content in a temporary file using Neovim inside kitty.
- Works only on **Wayland**.
- Uses `wl-paste` and `kitty` you can modify it to use other terminals also.

### `phone.sh`
Automates:
- ADB connection via IP
- Unlocking the phone
- Launching `scrcpy`
- Inputting your phone password (via `kdialog`)

### `watchYT.sh`
Stream or download YouTube videos via:
- VLC
- MPV
- A tool [awrit](https://github.com/chase/awrit)
- Or download with [yt-dlp](https://github.com/yt-dlp/yt-dlp)

Uses `kdialog` for GUI input and options.

---


## Notes
- These scripts are written with **Wayland + KDE** in mind.
- Tested on **Arch Linux**.


