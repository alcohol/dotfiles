#!/usr/bin/env bash

# clone Vundle and install Vim plugins
if [[ ! -d "$HOME/.vim/plugged" ]]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall +qall &
fi

if [[ ! -d "$HOME/.cache/rtorrent" ]]; then
  mkdir -p "$HOME/.cache/rtorrent/session"
fi
