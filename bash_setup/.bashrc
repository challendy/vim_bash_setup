#!/bin/bash
# A nice pretty bash environment.
#
# Gray Manley with help from Ryan Tomayko and the internet.

# the basics
: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}

# complete hostnames from this file
: ${HOSTFILE=~/.ssh/known_hosts}

# readline config
: ${INPUTRC=~/.inputrc}

# ----------------------------------------------------------------------
#  SHELL OPTIONS
# ----------------------------------------------------------------------

# Enables cd to correct minor typos ie. 'mkdir /foo && cd /foe && pwd' => /foo
shopt -s cdspell >/dev/null 2>&1
# Extended pattern matching ie. 'ls -d !(*gif|*jpg)' shows everything except jpg and gif.
shopt -s extglob >/dev/null 2>&1
# Append command history when using multiple shells instead of overwriting it.
shopt -s histappend >/dev/null 2>&1
# Allow tab completion of hosts found in $HOSTFILE which in this case is ~/.ssh/known_hosts
shopt -s hostcomplete >/dev/null 2>&1
# Don't attempt to tab complete without a preceding command.
shopt -s no_empty_cmd_completion >/dev/null 2>&1

# Notify of background job completion.
set -o notify

# Disable automatic core dumps.
ulimit -S -c 0

# Set default umask
umask 0022

# ----------------------------------------------------------------------
# PATH
# ----------------------------------------------------------------------

# we want the various sbins on the path along with /usr/local/bin
PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"

# I like to put my various aliases in a seperate file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Readline config
INPUTRC=$HOME/.inputrc

# ----------------------------------------------------------------------
# ENVIRONMENT CONFIGURATION
# ----------------------------------------------------------------------

# detect interactive shell
case "$-" in
    *i*) INTERACTIVE=yes ;;
    *)   unset INTERACTIVE ;;
esac

# detect login shell
case "$0" in
    -*) LOGIN=yes ;;
    *)  unset LOGIN ;;
esac

# enable en_US locale w/ utf-8 encodings if not already configured
: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

# always use PASSIVE mode ftp
: ${FTP_PASSIVE:=1}
export FTP_PASSIVE

# Don't list the same command more then once in history
HISTCONTROL=ignoreboth

# ----------------------------------------------------------------------
# PROMPT
# ----------------------------------------------------------------------

prompt_color() {
    PS1="\[\033[0;32m\]\h\[\033[0;36m\] \w\[\033[00m\] ∴ "
    PS2="\[\]continue \[\]> "
}

# ----------------------------------------------------------------------
# LS AND DIRCOLORS
# ----------------------------------------------------------------------

export CLICOLOR=1
export LSCOLORS=gxgxcxdxbxegedabagacad  # cyan directories

# --------------------------------------------------------------------
# MISC COMMANDS
# --------------------------------------------------------------------

# push SSH public key to another box
push_ssh_cert() {
    local _host
    test -f ~/.ssh/id_dsa.pub || ssh-keygen -t dsa
    for _host in "$@";
    do
        echo $_host
        ssh $_host 'cat >> ~/.ssh/authorized_keys' < ~/.ssh/id_dsa.pub
    done
}

# -------------------------------------------------------------------
# USER SHELL ENVIRONMENT
# -------------------------------------------------------------------

# Use the color prompt by default when interactive
test -n "$PS1" &&
prompt_color

# -------------------------------------------------------------------
# MOTD / FORTUNE
# -------------------------------------------------------------------

test -n "$INTERACTIVE" -a -n "$LOGIN" && {
    uname -prs
    uptime
}