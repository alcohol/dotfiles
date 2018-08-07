#!/usr/bin/env bash

# Make sure XDG_ variables are set regardless of environment,
# and create their respective directories if they do not exist yet.
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
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

# Check if Composer is available, and if so, add global Composer bin directory to PATH.
#  <!> Order here is important since `command` uses $PATH to check for existence.
export COMPOSER_HOME="$XDG_CONFIG_HOME/composer"
export COMPOSER_CACHE_DIR="$XDG_CACHE_HOME/composer"
for dir in "$COMPOSER_HOME" "$COMPOSER_CACHE_DIR"; do
  [[ ! -d $dir ]] && mkdir -p "$dir";
done
if command -v composer >/dev/null 2>&1; then
  # Add composer global bin dir to PATH if it exists.
  bindir=$(composer global config bin-dir --absolute 2> /dev/null)
  [[ -d $bindir ]] && PATH="$bindir:$PATH"
else
  # Check if Docker is available
  if command -v docker >/dev/null 2>&1; then
    composer () {
      tty=
      tty -s && tty=--tty
      docker run \
        $tty \
        --interactive \
        --rm \
        --cap-drop ALL \
        --env COMPOSER_HOME \
        --env COMPOSER_CACHE_DIR \
        --user $(id -u):$(id -g) \
        --volume $COMPOSER_HOME:$COMPOSER_HOME:delegated \
        --volume $COMPOSER_CACHE_DIR:$COMPOSER_CACHE_DIR:delegated \
        --volume /etc/passwd:/etc/passwd:ro \
        --volume /etc/group:/etc/group:ro \
        --volume $(pwd):/app \
        --workdir /app \
        composer "$@"
    }
  fi
fi

if ! command -v php > /dev/null 2>&1 && command -v docker > /dev/null 2>&1; then
  php () {
    tty=
    tty -s && tty=--tty
    docker run \
      $tty \
      --interactive \
      --rm \
      --cap-drop ALL \
      --user $(id -u):$(id -g) \
      --volume /etc/passwd:/etc/passwd:ro \
      --volume /etc/group:/etc/group:ro \
      --volume $(pwd):/app \
      --workdir /app \
      php:cli-alpine "$@"
  }
fi

# WeeChat does not use XDG specification but can read "config" dir from ENV
if command -v weechat >/dev/null 2>&1; then
  export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
fi
