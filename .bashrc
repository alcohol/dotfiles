#
# Read when opening a new (interactive) shell that is not a login shell.
#

# If not running interactively, exit
[[ $- != *i* ]] && return

stty -ixon

export CLICOLOR=1
export TERM="xterm-256color"
export PATH=${HOME}/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export HISTCONTROL=ignoreboth
export HISTIGNORE='l[sla]:[bf]g:pwd:clear:history'
export PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='vim -p -X'
export VISUAL=${EDITOR}
export GIT_EDITOR=${EDITOR}

[[ -s ${HOME}/.bash_prompt ]] && source ${HOME}/.bash_prompt
[[ -s ${HOME}/.aliases ]] && source ${HOME}/.aliases

kernel=`uname -s`

# Linux
if [[ "$kernel" == 'Linux' ]]; then
    shopt -s autocd checkhash checkwinsize cmdhist dirspell dotglob globstar histappend nocaseglob nocasematch nullglob
fi

# MacOSX
[[ -d /usr/local/opt/coreutils/libexec/gnubin ]] && export PATH=/usr/local/opt/coreutils/libexec/gnubin:${PATH}
