#!/usr/bin/env bash

#
# Read when opening a new (interactive) shell that is not a login shell.
#
# Skipped if --norc is passed or --rcfile <file> specifies another file.
#

# Source global bashrc if it exists
[[ -f /etc/bashrc ]] && source /etc/bashrc

# Linux specific shell options
[[ "$(uname -s)" == 'Linux' ]] && source "$HOME/.bash_shopt"

# Allow rebinding ctrl-{s,q}
stty -ixon -ixoff

# Base PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

# Extend PATH
[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"
[[ -d "$HOME/.krew/bin" ]] && PATH="${HOME}/.krew/bin:$PATH"

# Source scripts found in ~/.bashrc.d/
if [[ -d "$HOME/.bashrc.d" ]]; then
  for file in "$HOME"/.bashrc.d/*.sh; do
    source "$file"
  done
fi
