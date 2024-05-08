#!/bin/bash

dotfiles=(
  '.vimrc'
  '.tmux.conf'
  '.gemrc'
  '.gitconfig'
)

for file in "${dotfiles[@]}"; do
  src=$(pwd)/$file
  dest=$HOME/$file

  if [ -e "$dest" ]; then
    echo "Already exists $file"
  else
    ln -s "$src" "$dest"
    echo "Linked $file"
  fi
done
