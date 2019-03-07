#!/usr/bin/env bash

paste() {
  tail -n +1 -- "$@" | curl --data-binary "@-" https://paste.robbast.nl
}

man() {
  GROFF_NO_SGR=1 \
  LESS="--RAW-CONTROL-CHARS" \
  LESS_TERMCAP_mb=$(tput bold; tput setaf 2) \
  LESS_TERMCAP_md=$(tput bold; tput setaf 6) \
  LESS_TERMCAP_me=$(tput sgr0) \
  LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) \
  LESS_TERMCAP_se=$(tput rmso; tput sgr0) \
  LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) \
  LESS_TERMCAP_ue=$(tput rmul; tput sgr0) \
  LESS_TERMCAP_mr=$(tput rev) \
  LESS_TERMCAP_mh=$(tput dim) \
  LESS_TERMCAP_ZN=$(tput ssubm) \
  LESS_TERMCAP_ZV=$(tput rsubm) \
  LESS_TERMCAP_ZO=$(tput ssupm) \
  LESS_TERMCAP_ZW=$(tput rsupm) \
  command man "$@"
}

aliases() {
  alias mkdir='mkdir -p -v'
  alias grep='grep --color=auto'
  alias vi='vim'
  alias svim='sudoedit'
  alias h='history'
  alias rm='rm -i'
  alias cp='cp -i'
  alias mv='mv -i'
  alias ls='ls -hAF --color=auto'
  alias ll='ls -lp --group-directories-first'
  alias tmux='TERM=screen-256color tmux'
  alias muxenv='eval $(tmux showenv -s)'
}

aliases

if command -v trash >/dev/null 2>&1; then
  alias atom='ELECTRON_TRASH=trash-cli atom'
fi
