# asciiquarium-alacritty

Fish function that runs `asciiquarium` in a separate, tuned Alacritty window.

## Why

In Alacritty, asciiquarium looks wrong with default settings: the castle and
whale outlines are drawn in bold black, which is invisible on a black background.
The function opens a new window with a small font (more cells, more fish) and
remaps black so every sprite is visible. Your `alacritty.toml` is not touched,
all settings are passed as one-off `-o` flags.

## Requirements

- fish
- alacritty
- asciiquarium
- setsid (part of util-linux, preinstalled on Arch)

## Install

```fish
cp asciiquarium.fish ~/.config/fish/functions/
```

Fish picks it up automatically. After that, `asciiquarium` opens the tuned window
and the original terminal is free (closing it does not close the aquarium).
Press `q` to quit.

## Tweak

Edit the values inside the function:

- `font.size=6`: bigger number gives fewer, larger fish
- `#5c6370`: color of the "bright black" (castle walls, whale outline)

## Uninstall

```fish
rm ~/.config/fish/functions/asciiquarium.fish
```
