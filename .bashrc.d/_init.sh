#!/usr/bin/env bash

dir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

# only run once
if [[ -f $dir/_init ]]; then
  return
fi

# clone Vundle and install Vim plugins
if [[ ! -d $HOME/.vim/bundle ]]; then
  git clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
  vim +PluginInstall +qall &
fi

touch "$dir/_init"
