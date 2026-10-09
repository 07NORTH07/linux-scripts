function asciiquarium --description 'asciiquarium in a tuned alacritty window'
    setsid -f alacritty -o font.size=6 -o 'colors.draw_bold_text_with_bright_colors=true' -o 'colors.normal.black="#000000"' -o 'colors.bright.black="#5c6370"' -e asciiquarium $argv >/dev/null 2>&1
end
