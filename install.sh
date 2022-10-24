#!/bin/sh

dir="$HOME/.local/share/42dotfiles"

git clone https://github.com/thibautdbs/42dotfiles.git $dir

"$dir/bin/chezmoi" --source "$dir" init --apply
