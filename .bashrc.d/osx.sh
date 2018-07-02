#!/usr/bin/env bash

if (( ! EUID )); then
  return
fi

# Check if keychain is available, and if so, run it through eval to export
# the environment variables SSH_AUTH_SOCK and SSH_AGENT_PID.
if command -v keychain >/dev/null 2>&1; then
  [[ -f ~/.ssh/id_rsa ]] && eval `keychain --quiet --agents ssh --eval id_rsa`
fi
