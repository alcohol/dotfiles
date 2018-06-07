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

if (( ! EUID )); then
  exit
fi

# Check if keychain is available, and if so, run it through eval to export
# the environment variables SSH_AUTH_SOCK and SSH_AGENT_PID.
if command -v keychain >/dev/null 2>&1; then
  [[ -f ~/.ssh/id_rsa ]] && eval `keychain --quiet --agents ssh --eval id_rsa`
fi
