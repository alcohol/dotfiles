#!/usr/bin/env bash

if [[ -f /usr/local/etc/bash_completion ]]; then
  source /usr/local/etc/bash_completion
elif [[ -f /usr/share/bash-completion/bash_completion ]]; then
  source /usr/share/bash-completion/bash_completion
fi

for file in \
  "/opt/google-cloud-sdk/completion.bash.inc" \
  "/opt/google-cloud-sdk/path.bash.inc";
do
  [[ -f "$file" ]] && source "$file"
done
