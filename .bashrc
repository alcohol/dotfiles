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
kernel=`uname -s`
if [[ "$kernel" == 'Linux' ]]; then
  shopt -s autocd
  shopt -s cdspell
  shopt -s checkhash
  shopt -s checkjobs
  shopt -s checkwinsize
  shopt -s cmdhist
  shopt -s dirspell
  shopt -s dotglob
  shopt -s extglob
  shopt -s globstar
  shopt -s histappend
  shopt -s nocaseglob
  shopt -s nocasematch
fi

# {{{ exports

# Expand PATH based on what is installed through homebrew etc.
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"
for dir in \
  "/usr/local/opt/python/libexec/bin" \
  "/usr/local/opt/coreutils/libexec/gnubin" \
  "/usr/local/opt/findutils/libexec/gnubin" \
  "/usr/local/opt/gnu-tar/libexec/gnubin" \
  "/usr/local/opt/gnu-sed/libexec/gnubin" \
  "$HOME/bin";
  do [[ -d $dir ]] && PATH="$dir:$PATH"; done

# Make sure XDG_ variables are set regardless of environment.
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
for dir in \
  "$XDG_CONFIG_HOME" \
  "$XDG_CACHE_HOME" \
  "$XDG_DATA_HOME";
  do [[ ! -d $dir ]] && mkdir -p "$dir"; done

# Check if Composer is available, and if so, add global Composer bin directory.
#  <!> Order here is important since `command` uses $PATH to check for existence.
if command -v composer >/dev/null 2>&1; then
  # Manually override composer home and cache dir using XDG_ specification directories.
  export COMPOSER_HOME="$XDG_CONFIG_HOME/composer"
  export COMPOSER_CACHE_DIR="$XDG_CACHE_HOME/composer"
  # Add composer global bin dir to PATH if it exists.
  bindir=$(composer global config bin-dir --absolute 2> /dev/null)
  [[ -d $bindir ]] && PATH="$bindir:$PATH"
fi

# WeeChat does not use XDG specification but can read "config" dir from ENV
if command -v weechat >/dev/null 2>&1;
  then export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
fi

export CLICOLOR=1
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE='cd:l[sla]:[bf]g:pwd:clear:history'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='vim -p -X'
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR

# }}}
# {{{ autocomplete

[[ -f /usr/share/git/completion/git-completion.bash ]] && source /usr/share/git/completion/git-completion.bash
[[ -f /usr/local/etc/bash_completion.d/git-completion.bash ]] && source /usr/local/etc/bash_completion.d/git-completion.bash

# }}}
# {{{ keychain

# Check if keychain is available, and if so, run it through eval to export
# the environment variables SSH_AUTH_SOCK and SSH_AGENT_PID.
if command -v keychain >/dev/null 2>&1; then
  [[ -f ~/.ssh/id_rsa ]] && eval `keychain --quiet --agents ssh --eval id_rsa`
fi

# }}}
# {{{ colors

txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
txtrst='\e[0m' # Text Reset

# }}}
# {{{ prompt

if (( EUID )); then
  export PS1="\[$bldwht\]\u\[$txtrst\]@\[$bldwht\]\H\[$txtrst\] \[$bldblu\]\w \[$bldwht\]> \[$txtrst\]"
else
  export PS1="\[$bldwht\]\u\[$txtrst\]@\[$bldwht\]\H\[$txtrst\] \[$bldblu\]\w \[$bldred\]> \[$txtrst\]"
fi

export PS2="> "
export PS3="> "
export PS4="+ "

# }}}
# {{{ aliases & functions

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

# }}}
# {{{ cleanup

unset txtblk txtred txtgrn txtylw txtblu txtpur txtcyn txtwht
unset bldblk bldred bldgrn bldylw bldblu bldpur bldcyn bldwht
unset txtrst

# }}}
