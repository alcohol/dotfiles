#!/usr/bin/env bash

#
# Read when opening a new (interactive) shell that is not a login shell.
#
# Skipped if --norc is passed or --rcfile <file> specifies another file.
#

# Source global profiles if they exist
[[ -f /etc/bashrc ]] && source /etc/bashrc
[[ -f /etc/bash.bashrc ]] && source /etc/bash.bashrc
[[ -f /etc/profile ]] && source /etc/profile

# Linux specific shell options
[[ "$(uname -s)" == 'Linux' ]] && source "$HOME/.bash_shopt"

# Allow rebinding ctrl-{s,q}
[[ $- == *i* ]] && stty -ixon -ixoff

# Base PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

# Extend PATH
[[ -d "$HOME/bin" ]] && PATH="$PATH:$HOME/bin"
[[ -d "$HOME/.krew/bin" ]] && PATH="$PATH:$HOME/.krew/bin"
[[ -d "$HOME/.local/bin" ]] && PATH="$PATH:$HOME/.local/bin"

# Source scripts found in ~/.bashrc.d/
if [[ -d "$HOME/.bashrc.d" ]]; then
  for file in "$HOME"/.bashrc.d/*.sh; do
    source "$file"
  done
fi
