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

if (( ! EUID )); then
  export PS1="\[$bldwht\][\[$txtpur\]\D{%F %T %z}\[$bldwht\]] \[$bldred\]\u\[$txtrst\]@\[$bldwht\]\H \[$bldblu\]\w \[$bldred\]\$\[$txtrst\] "
else
  export PS1="\[$bldwht\][\[$txtpur\]\D{%F %T %z}\[$bldwht\]] \[$bldgrn\]\u\[$txtrst\]@\[$bldwht\]\H \[$bldblu\]\w \[$bldwht\]\$\[$txtrst\] "
fi

export PS2="> "
export PS3="> "
export PS4="+ "

unset txtblk txtred txtgrn txtylw txtblu txtpur txtcyn txtwht
unset bldblk bldred bldgrn bldylw bldblu bldpur bldcyn bldwht
unset txtrst
