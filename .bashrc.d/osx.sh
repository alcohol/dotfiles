#!/usr/bin/env bash

# Bail if OS is not Darwin based.
[[ "$(uname -s)" != 'Darwin' ]] && return

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
  do
    [[ -d $dir ]] && export PATH="$dir:$PATH"
  done
fi

# Check if keychain is available, and if so, run it through eval to export
# the environment variables SSH_AUTH_SOCK and SSH_AGENT_PID.
if command -v keychain >/dev/null 2>&1; then
  eval $(keychain --quiet --ignore-missing --agents ssh --eval id_rsa id_ed25519)
fi
