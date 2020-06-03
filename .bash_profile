#!/usr/bin/env bash

#
# First /etc/profile is read (if it exists), then the first file from
# the following list that exists and is readable is processed:
#
#   ~/.bash_profile
#   ~/.bash_login
#   ~/.profile
#

[[ -f "$HOME/.bashrc" ]] && source "$HOME/.bashrc"
