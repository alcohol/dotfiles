export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.sock"

if [ ! -S "$SSH_AUTH_SOCK" ]; then
    rm -f "$SSH_AUTH_SOCK"
    ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null
fi

for key in "$HOME"/.ssh/id_*; do
    [ -f "$key" ] || continue

    case "$key" in
        *.pub|*_config|*.known_hosts) continue ;;
    esac

    ssh-add "$key" 2>/dev/null
done

