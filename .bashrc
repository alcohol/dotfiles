#!/usr/bin/env bash
#
# Read when opening a new (interactive) shell that is not a login shell.
#

# source global bashrc
[[ -f /etc/bashrc ]] && source /etc/bashrc

# exit if shell is not interactive
[[ $- != *i* ]] && return

# feature that annoys me, also i wanna rebind ctrl-{s,q}
stty -ixon -ixoff

# clean slate
unalias -a

# some shell options on linux
kernel=$(uname -s)
if [[ "$kernel" == 'Linux' ]]; then
  source "$HOME/.bash_shopt"
fi

export PATH="$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"


if [[ -f /usr/local/etc/bash_completion ]]; then
  source /usr/local/etc/bash_completion
elif [[ -f /usr/share/bash-completion/bash_completion ]]; then
  source /usr/share/bash-completion/bash_completion
fi

if [[ -d $HOME/.bashrc.d ]]; then
  for file in "$HOME"/.bashrc.d/*.sh; do
    source "$file"
  done
fi
