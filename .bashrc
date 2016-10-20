#
# Read when opening a new (interactive) shell that is not a login shell.
#

# System wide aliases and functions should go in /etc/bashrc. Personal
# environment variables and startup programs should go into ~/.bash_profile.
# Personal aliases and functions should go into ~/.bashrc.

# source global bashrc
[[ -f /etc/bashrc ]] && source /etc/bashrc

# if prompt is not interactive, exit
[[ $- != *i* ]] && return

# disable flow control (allows rebinding ctrl+s/q).
stty -ixon -ixoff

# if on linux, set some shell options
kernel=`uname -s`
if [[ "$kernel" == 'Linux' ]]; then
    shopt -s autocd cdspell checkhash checkjobs checkwinsize cmdhist dirspell dotglob extglob globstar histappend nocaseglob nocasematch
fi

# {{{ exports

declare -x PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

directories=(
    "/usr/local/opt/coreutils/libexec/gnubin"
    "/usr/local/opt/gnu-tar/libexec/gnubin"
    "/usr/local/opt/gnu-sed/libexec/gnubin"
)

[[ -d $HOME ]] && directories+=("${HOME}/bin")

for dir in "${directories[@]}"; do [[ -d "$dir" ]] && PATH="$dir:$PATH"; done

# Check if Composer is available, and if so, add global Composer bin directory.
#  <!> Order here is important since `command` uses $PATH to check for existence.
if command -v composer >/dev/null 2>&1; then
    PATH="$(composer global config bin-dir --absolute 2>/dev/null):$PATH"
fi

export CLICOLOR=1
export HISTCONTROL=ignoreboth
export HISTIGNORE='cd:l[sla]:[bf]g:pwd:clear:history'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='vim -p -X'
export VISUAL=${EDITOR}
export GIT_EDITOR=${EDITOR}

# }}}
# {{{ autocomplete & other autorun stuff

# Check if keychain is available, and if so, run it through eval to export
# the environment variables SSH_AUTH_SOCK and SSH_AGENT_PID.
if command -v keychain >/dev/null 2>&1; then
    [[ -f "${HOME}/.ssh/id_rsa" ]] && eval `keychain --quiet --agents ssh --eval id_rsa`
fi

[[ -f /usr/share/git/completion/git-completion.bash ]] && source /usr/share/git/completion/git-completion.bash

# }}}
# {{{ aliases

alias mkdir='mkdir -p -v'
alias grep='grep --color=auto'
alias vi='vim'
alias svim='sudoedit'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls -hAF --color=auto'
alias ll='ls -lp --group-directories-first'
alias tmux='TERM=screen-256color tmux'
alias muxenv='eval $(tmux showenv -s)'
alias xphp='php -dzend_extension=xdebug.so -dxdebug.remote_autostart=1 -dxdebug.remote_enable=1 -dxdebug.remote_mode=req -dxdebug.remote_port=9000 -dxdebug.remote_host=127.0.0.1 -dxdebug.remote_connect_back=0'

paste() {
    tail -n +1 -- "$@" | curl --data-binary "@-" https://paste.robbast.nl
}

man() {
    LESS_TERMCAP_md=$'\e[01;36m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
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
txtbld='\e[1m'    # Bold
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

PS1="\[$txtgrn\]\u\[$txtcyn\]@\[$txtgrn\]\h\[$txtrst\] \[$txtylw\]\w\[$txtrst\] \[$txtbld\]\\$\[$txtrst\] "
PS2=">\ "
PS3=">\ "
PS4="+\ "

unset txtblk txtred txtgrn txtylw txtblu txtpur txtcyn txtwht txtbld bldblk bldred bldgrn
unset bldpur bldcyn bldwht unkblk undred undgrn undylw undblu undpur undcyn undwht bakblk
unset bakylw bakblu bakpur bakcyn bakwht txtrst bldylw bldblu bakred bakgrn

# }}}
