#!/usr/bin/env bash

# clone Vundle and install Vim plugins
if [[ ! -d $HOME/.vim/bundle ]]; then
  git clone https://github.com/VundleVim/Vundle.vim.git "$HOME"/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall &
fi
