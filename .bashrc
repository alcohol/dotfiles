#
# Read when opening a new (interactive) shell that is not a login shell.
#

# System wide aliases and functions should go in /etc/bashrc. Personal
# environment variables and startup programs should go into ~/.bash_profile.
# Personal aliases and functions should go into ~/.bashrc.
[[ -f /etc/bashrc ]] && source /etc/bashrc

# It the shell is not interactive, bail.
[[ $- != *i* ]] && return

# Custom bash prompt.
[[ -s ${HOME}/.bash_prompt ]] && source ${HOME}/.bash_prompt

# Disable flow control (allows rebinding ctrl+s/q).
stty -ixon -ixoff

kernel=`uname -s`
if [[ "$kernel" == 'Linux' ]]; then
    shopt -s autocd checkhash checkwinsize cmdhist dirspell dotglob globstar histappend nocaseglob nocasematch
fi

# Personal aliases.
[[ -s ${HOME}/.aliases ]] && source ${HOME}/.aliases
# Personal exports.
[[ -s ${HOME}/.exports ]] && source ${HOME}/.exports
