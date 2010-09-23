#!/bin/bash
# A nice pretty bash environment.
#
# Chris Hallendy with help from Gray Manley, Ryan Tomayko and the internet.

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

# shell opts. see bash(1) for details
shopt -s cdspell >/dev/null 2>&1
shopt -s extglob >/dev/null 2>&1
shopt -s histappend >/dev/null 2>&1
shopt -s hostcomplete >/dev/null 2>&1
shopt -s interactive_comments >/dev/null 2>&1
shopt -u mailwarn >/dev/null 2>&1
shopt -s no_empty_cmd_completion >/dev/null 2>&1

# that new mail crap
unset MAILCHECK

# disable core dumps
ulimit -S -c 0

# default umask
umask 0022

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

# ----------------------------------------------------------------------
# PROMPT
# ----------------------------------------------------------------------

prompt_color() {
    PS1="\[\033[0;32m\]\h\[\033[0;36m\] \w\[\033[00m\] ∴ "
    PS2="\[[33;1m\]continue \[[0m[1m\]> "
}

# ----------------------------------------------------------------------
# ALIASES / FUNCTIONS
# ----------------------------------------------------------------------

# GENERAL #
alias ls="ls -a" # general list of files but includes hiden things too
alias lsa='ls -lah' # l for list style, a for all including hidden, h for human readable file sizes
alias h='history' # show history
alias c='clear' # clear terminal
alias ..='cd ..' # move up 1 dir
alias ...='cd ../..' # move up 2 dirs
alias rbash=". ~/.bash_profile" # reloads bash profile
alias ebash='mvim ~/.bashrc' # edit bash_profile in macvim
alias ping='ping -c 5' # pings specified server 5 times
alias shotgun='shotgun --server thin --port 4567'
alias ps='ps ux' 
alias fkill='kill -9'

# RUBY #
alias irb='irb --readline -r irb/completion -rubygems' # use readline, completion and require rubygems in irb
# allows you to open specified gem in textmate! type: mategem <gem name>
function mategem {
mate /Library/Ruby/Gems/1.8/gems/`ls /Library/Ruby/Gems/1.8/gems/|grep $1|sort|tail -1`
}

# RAILS #
alias ss="script/server"
alias sc="script/console"
alias sg="script/generate"
alias rdbm="rake db:migrate"
alias rdbc="rake db:create"

# GIT #
alias gc="git commit -m"
alias gs="git status"
alias gp="git push origin master"
alias gb="git branch"
alias spec="bundle exec rspec"

# ----------------------------------------------------------------------
# BASH COMPLETION
# ----------------------------------------------------------------------

  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi
  
  unset bash bmajor bminor

# override and disable tilde expansion
_expand() {
    return 0
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

# bring in rbdev functions
. rbdev 2>/dev/null || true

# source ~/.shenv now if it exists
test -r ~/.shenv &&
. ~/.shenv

# Use the color prompt by default when interactive
test -n "$PS1" &&
prompt_color

# -------------------------------------------------------------------
# MOTD / FORTUNE
# -------------------------------------------------------------------

test -n "$INTERACTIVE" -a -n "$LOGIN" && {
    uname -npsr
    uptime
}

#Pman for viewing man pages in preview
function pman () {
    man -t $1 | open -f -a /Applications/Preview.app
}


