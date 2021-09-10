#!/usr/bin/env bash

export CLICOLOR=1
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE='cd:l[sla]:[bf]g:pwd:clear:history'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='vim -p -X'
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR

# Make sure XDG_ variables are set regardless of environment,
# and create their respective directories if they do not exist yet.

# Defines the base directory relative to which user-specific configuration files should be stored.
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
# Defines the base directory relative to which user-specific non-essential data files should be stored.
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
# Defines the base directory relative to which user-specific data files should be stored.
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
# Contains state data that should persist between (application) restarts, but that is not important
# or portable enough to the user that it should be stored in $XDG_DATA_HOME. It may contain:
#
# - actions history (logs, history, recently used files, …)
# - current state of the application that can be reused on a restart (view, layout, open files, undo history, …)
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
# Defines the base directory relative to which user-specific non-essential runtime files and other
# file objects (such as sockets, named pipes, ...) should be stored.
runtimedir="/run/user/$(id -u)"
export XDG_RUNTIME_DIR=$runtimedir

for dir in \
  "$XDG_CONFIG_HOME" \
  "$XDG_CACHE_HOME" \
  "$XDG_DATA_HOME";
do
  [[ ! -d $dir ]] && mkdir -p "$dir"
done

# Make sure Composer honors XDG specification.
export COMPOSER_HOME="$XDG_CONFIG_HOME/composer"
export COMPOSER_CACHE_DIR="$XDG_CACHE_HOME/composer"

for dir in \
  "$COMPOSER_HOME" \
  "$COMPOSER_CACHE_DIR";
do
  [[ ! -d $dir ]] && mkdir -p "$dir"
done

# WeeChat does not use XDG specification but can read "config" dir from ENV.
if command -v weechat >/dev/null 2>&1; then
  export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
fi
