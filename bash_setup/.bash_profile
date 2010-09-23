. ~/.bashrc
PATH="/usr/local/bin:/usr/local/sbin:$PATH" # if not already present
PATH="$PATH:/usr/local/mysql/bin"

export PATH=$PATH:/usr/local/bin

#RVM Commands
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
