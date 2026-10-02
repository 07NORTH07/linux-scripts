#!/bin/bash

# ─────────────────────────────────────────────
#  SPT — installer
#  github.com/07NORTH07
#
#  sudo bash install.sh   -> system-wide  (/usr/local/bin/spt)
#  bash install.sh        -> current user (~/.local/bin/spt)
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
echo -e "${C_WHITE}  SPT — installer${C_RESET}"
echo -e "${C_GRAY}  ──────────────────────────────${C_RESET}"
echo

# ── target directory ──────────────────
if [[ $EUID -eq 0 ]]; then
    TARGET_DIR="/usr/local/bin"
    info "Running as root: system-wide install to $TARGET_DIR"
else
    TARGET_DIR="$HOME/.local/bin"
    info "Running as user: installing to $TARGET_DIR  (use sudo for system-wide)"
fi

# ── dependency check ──────────────────
echo
echo -e "${C_GRAY}  Checking dependencies...${C_RESET}"
MISSING=()
for cmd in yt-dlp ffmpeg python3 curl; do
    if command -v "$cmd" &>/dev/null; then
        ok "$cmd"
    else
        err "$cmd — not found"
        MISSING+=("$cmd")
    fi
done

if python3 -c "import mutagen" &>/dev/null; then
    ok "python-mutagen"
else
    err "python-mutagen — not found"
    MISSING+=("python-mutagen")
fi

if [[ ${#MISSING[@]} -gt 0 ]]; then
    echo
    err "Install the missing packages:"
    if command -v pacman &>/dev/null; then
        echo -e "  ${C_YELLOW}sudo pacman -S yt-dlp ffmpeg python python-mutagen curl${C_RESET}"
    elif command -v apt &>/dev/null; then
        echo -e "  ${C_YELLOW}sudo apt update${C_RESET}"
        echo -e "  ${C_YELLOW}sudo apt install ffmpeg python3 python3-pip python3-mutagen curl${C_RESET}"
        echo -e "  ${C_GRAY}yt-dlp from apt is often outdated, use pip:${C_RESET}"
        echo -e "  ${C_YELLOW}python3 -m pip install -U \"yt-dlp[default]\" --break-system-packages${C_RESET}"
    elif command -v dnf &>/dev/null; then
        echo -e "  ${C_YELLOW}sudo dnf install yt-dlp ffmpeg python3-mutagen curl${C_RESET}"
        echo -e "  ${C_GRAY}Full ffmpeg on Fedora needs RPM Fusion${C_RESET}"
    elif command -v zypper &>/dev/null; then
        echo -e "  ${C_YELLOW}sudo zypper install yt-dlp ffmpeg python3-mutagen curl${C_RESET}"
        echo -e "  ${C_GRAY}Full ffmpeg on openSUSE needs the Packman repository${C_RESET}"
    else
        echo -e "  ${C_GRAY}Install yt-dlp, ffmpeg, python3, python3-mutagen, curl via your package manager${C_RESET}"
    fi
    echo
    read -rp "  Continue anyway? [y/N] " ans
    [[ "$ans" != "y" && "$ans" != "Y" ]] && exit 1
fi

# ── copy file ─────────────────────────
echo
echo -e "${C_GRAY}  Installing script...${C_RESET}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [[ ! -f "$SCRIPT_DIR/bin/spt" ]]; then
    err "File bin/spt not found next to install.sh"
    exit 1
fi

mkdir -p "$TARGET_DIR" || { err "Cannot create $TARGET_DIR"; exit 1; }
cp "$SCRIPT_DIR/bin/spt" "$TARGET_DIR/spt" || { err "Cannot write to $TARGET_DIR"; exit 1; }
chmod +x "$TARGET_DIR/spt"

ok "spt -> $TARGET_DIR/spt"

# ── PATH check (user install) ─────────
case ":$PATH:" in
    *":$TARGET_DIR:"*) ;;
    *)
        echo
        err "$TARGET_DIR is not in your PATH."
        echo -e "  ${C_GRAY}Add this line to ~/.bashrc or ~/.zshrc and restart the terminal:${C_RESET}"
        echo -e "  ${C_YELLOW}export PATH=\"\$HOME/.local/bin:\$PATH\"${C_RESET}"
        echo -e "  ${C_GRAY}For fish:${C_RESET}"
        echo -e "  ${C_YELLOW}fish_add_path ~/.local/bin${C_RESET}"
        ;;
esac

# ── done ──────────────────────────────
echo
echo -e "${C_GREEN}  Done! Run: spt${C_RESET}"
echo -e "${C_GRAY}  On first run you will choose a language.${C_RESET}"
echo -e "${C_GRAY}  Usage: spt | spt uninstall | spt --help${C_RESET}"
echo
