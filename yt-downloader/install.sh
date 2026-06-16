#!/bin/bash

# ─────────────────────────────────────────────
#  YT DOWNLOADER — installer
#  github.com/07NORTH07
# ─────────────────────────────────────────────

C_GREEN='\033[0;32m'
C_RED='\033[0;31m'
C_YELLOW='\033[0;33m'
C_GRAY='\033[0;90m'
C_WHITE='\033[0;97m'
C_RESET='\033[0m'

ok()   { echo -e "  ${C_GREEN}[v]${C_RESET} $1"; }
err()  { echo -e "  ${C_RED}[x]${C_RESET} $1"; }
info() { echo -e "  ${C_GRAY}[~]${C_RESET} $1"; }

echo
echo -e "${C_WHITE}  YT DOWNLOADER — installer${C_RESET}"
echo -e "${C_GRAY}  ──────────────────────────────${C_RESET}"
echo

# ── sudo check ────────────────────────
if [[ $EUID -ne 0 ]]; then
    err "Run with sudo: sudo bash install.sh"
    exit 1
fi

# ── dependency check ─────────────────
echo -e "${C_GRAY}  Checking dependencies...${C_RESET}"
MISSING=()
for pkg in yt-dlp ffmpeg python3; do
    if command -v "$pkg" &>/dev/null; then
        ok "$pkg"
    else
        err "$pkg — not found"
        MISSING+=("$pkg")
    fi
done

for pymod in unidecode mutagen; do
    if python3 -c "import $pymod" &>/dev/null; then
        ok "python-$pymod"
    else
        err "python-$pymod — not found"
        MISSING+=("python-$pymod")
    fi
done

if [[ ${#MISSING[@]} -gt 0 ]]; then
    echo
    err "Install the missing packages:"
    if command -v apt &>/dev/null; then
        echo -e "  ${C_YELLOW}sudo apt update${C_RESET}"
        echo -e "  ${C_YELLOW}sudo apt install yt-dlp ffmpeg python3 python3-pip python3-unidecode python3-mutagen${C_RESET}"
        echo -e "  ${C_GRAY}If apt doesn't have yt-dlp:${C_RESET}"
        echo -e "  ${C_YELLOW}python3 -m pip install -U \"yt-dlp[default]\" --break-system-packages${C_RESET}"
    elif command -v pacman &>/dev/null; then
        echo -e "  ${C_YELLOW}sudo pacman -S yt-dlp ffmpeg python python-unidecode python-mutagen${C_RESET}"
    else
        echo -e "  ${C_GRAY}Install yt-dlp, ffmpeg, python3, python3-unidecode, python3-mutagen via your package manager${C_RESET}"
    fi
    echo
    read -rp "  Continue anyway? [y/N] " ans
    [[ "$ans" != "y" && "$ans" != "Y" ]] && exit 1
fi

# ── copy files ─────────────────────
echo
echo -e "${C_GRAY}  Installing scripts...${C_RESET}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [[ ! -f "$SCRIPT_DIR/bin/yt" ]] || [[ ! -f "$SCRIPT_DIR/bin/yt-clean" ]]; then
    err "Files bin/yt or bin/yt-clean not found next to install.sh"
    exit 1
fi

cp "$SCRIPT_DIR/bin/yt"       /usr/bin/yt
cp "$SCRIPT_DIR/bin/yt-clean" /usr/bin/yt-clean
chmod +x /usr/bin/yt /usr/bin/yt-clean

ok "yt       -> /usr/bin/yt"
ok "yt-clean -> /usr/bin/yt-clean"

# ── done ────────────────────────────────
echo
echo -e "${C_GREEN}  Done! Run: yt${C_RESET}"
echo -e "${C_GRAY}  On first run you will choose a language and folders.${C_RESET}"
echo -e "${C_GRAY}  Usage: yt | yt mp3 | yt mp4 | yt thumb <url> | yt uninstall${C_RESET}"
echo
