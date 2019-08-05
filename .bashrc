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

# Expand PATH based on what is installed through homebrew, if installed.
if command -v brew >/dev/null 2>&1; then
  for dir in \
    "/usr/local/opt/python/libexec/bin" \
    "/usr/local/opt/coreutils/libexec/gnubin" \
    "/usr/local/opt/findutils/libexec/gnubin" \
    "/usr/local/opt/gnu-tar/libexec/gnubin" \
    "/usr/local/opt/gnu-sed/libexec/gnubin" \
    "/usr/local/opt/make/libexec/gnubin" \
    "/usr/local/opt/sqlite/bin" \
    "/usr/local/opt/curl/bin";
    do [[ -d $dir ]] && PATH="$dir:$PATH"; done
fi


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
