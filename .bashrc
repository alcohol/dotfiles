#
# Read when opening a new (interactive) shell that is not a login shell.
#

# source global bashrc
[[ -f /etc/bashrc ]] && source /etc/bashrc

# exit if shell is not interactive
[[ $- != *i* ]] && return

# feature that annoys me, also i wanna rebind ctrl-{s,q}
stty -ixon -ixoff

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

# it's my shit
umask 077

# {{{ exports

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"
for dir in \
  "/usr/local/opt/coreutils/libexec/gnubin" \
  "/usr/local/opt/gnu-tar/libexec/gnubin" \
  "/usr/local/opt/gnu-sed/libexec/gnubin" \
  "$HOME/bin";
  do [[ -d $dir ]] && PATH="$dir:$PATH"; done

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
  export COMPOSER_HOME="$XDG_CONFIG_HOME/composer"
  export COMPOSER_CACHE_DIR="$XDG_CACHE_HOME/composer"
  PATH="$(composer global config bin-dir --absolute 2>/dev/null):$PATH"
fi

# WeeChat does not use XDG specification but can read "config" dir from ENV
if command -v weechat >/dev/null 2>&1;
  then export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
fi

# Setup Go environment
if command -v go >/dev/null 2>&1; then
  export GOROOT="$(go env GOROOT)"
  export GOPATH="$HOME/projects/go"
fi

export CLICOLOR=1
export HISTCONTROL=ignoreboth
export HISTIGNORE='cd:l[sla]:[bf]g:pwd:clear:history'
export HISTFILE="$XDG_DATA_HOME"/bash/history
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='vim -p -X'
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR

# }}}
# {{{ autocomplete

[[ -f /usr/share/git/completion/git-completion.bash ]] && source /usr/share/git/completion/git-completion.bash

# }}}
# {{{ keychain

# Check if keychain is available, and if so, run it through eval to export
# the environment variables SSH_AUTH_SOCK and SSH_AGENT_PID.
if command -v keychain >/dev/null 2>&1; then
  [[ -f ~/.ssh/id_rsa ]] && eval `keychain --quiet --agents ssh --eval id_rsa`
fi

# }}}
# {{{ aliases & functions

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

paste() {
  tail -n +1 -- "$@" | curl --data-binary "@-" https://paste.robbast.nl
}

man() {
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_md=$'\e[01;36m' \
  LESS_TERMCAP_mb=$'\e[01;36m' \
  LESS_TERMCAP_us=$'\e[01;32m' \
  LESS_TERMCAP_so=$'\e[01;44;33m' \
  command man "$@"
}

# }}}
# {{{ prompt

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

if (( EUID )); then
  export PS1="\[$bldwht\]\u \[$bldblu\]\w \[$bldwht\]> \[$txtrst\]"
else
  export PS1="\[$bldwht\]\u \[$bldblu\]\w \[$bldred\]> \[$txtrst\]"
fi

export PS2="> "
export PS3="> "
export PS4="+ "

unset txtblk txtred txtgrn txtylw txtblu txtpur txtcyn txtwht
unset bldblk bldred bldgrn bldylw bldblu bldpur bldcyn bldwht
unset txtrst

# }}}
