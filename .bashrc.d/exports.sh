#!/usr/bin/env bash

# Make sure XDG_ variables are set regardless of environment,
# and create their respective directories if they do not exist yet.
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

for dir in "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME"; do
  [[ ! -d $dir ]] && mkdir -p "$dir";
done

export CLICOLOR=1
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE='cd:l[sla]:[bf]g:pwd:clear:history'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='vim -p -X'
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR

if (( ! EUID )); then
  return
fi

export COMPOSER_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/composer"
export COMPOSER_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/composer"

for dir in "$COMPOSER_HOME" "$COMPOSER_CACHE_DIR"; do
  [[ ! -d $dir ]] && mkdir -p "$dir";
done

# WeeChat does not use XDG specification but can read "config" dir from ENV
if command -v weechat >/dev/null 2>&1; then
  export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
fi
