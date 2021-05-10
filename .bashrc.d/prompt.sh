#!/usr/bin/env bash

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

parse_git_branch()
{
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# PS1 is the primary prompt which is displayed before each command, thus it is the one most people customize.
if (( ! EUID )); then
  export PS1="\[$bldwht\][\[$txtpur\]\D{%F %T %z}\[$bldwht\]] \[$bldred\]\u\[$txtrst\]@\[$bldwht\]\H \[$bldblu\]\w \[$bldylw\]\$(parse_git_branch)\n\[$bldred\]\$\[$txtrst\] "
else
  export PS1="\[$bldwht\][\[$txtpur\]\D{%F %T %z}\[$bldwht\]] \[$bldgrn\]\u\[$txtrst\]@\[$bldwht\]\H \[$bldblu\]\w \[$bldylw\]\$(parse_git_branch)\n\[$bldwht\]\$\[$txtrst\] "
fi

# PS2 is the secondary prompt displayed when a command needs more input (e.g. a multi-line command).
export PS2="> "

# PS3 is not very commonly used. It is the prompt displayed for Bash's select built-in which displays interactive menus. Unlike the other prompts, it does not expand Bash escape sequences. Usually you would customize it in the script where the select is used rather than in your .bashrc.
export PS3="> "

# PS4 is also not commonly used. It is displayed when debugging bash scripts to indicate levels of indirection. The first character is repeated to indicate deeper levels.
export PS4="+ "

unset txtblk txtred txtgrn txtylw txtblu txtpur txtcyn txtwht
unset bldblk bldred bldgrn bldylw bldblu bldpur bldcyn bldwht
unset txtrst
