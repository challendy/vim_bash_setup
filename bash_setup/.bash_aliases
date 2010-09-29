###########
# GENERAL #
###########
alias lsa='ls -lah' # l for list style, a for all including hidden, h for human readable file sizes
alias h='history' # Show history
alias c='clear' # Clear terminal
alias ..='cd ..' # Move up 1 dir
alias ...='cd ../..' # Move up 2 dirs
alias rbash=". ~/.bash_profile" # reloads bash profile
alias ebash='mate ~/.bashrc ~/.bash_aliases ~/.inputrc' # Open our bash config files in textmate.
alias ping='ping -c 5' # Limit command to ping the specified server only 5 times.
alias psc='ps ux' # Good overview of running processes.
alias fkill='kill -9' # For those hard to kill processes.

function pman () {
  man -t $1 | open -f -a /Applications/Preview.app
}

########
# RUBY #
########
alias irb='irb --readline -r irb/completion -rubygems' # use readline, completion and require rubygems in irb
# Opens specified gem in textmate: mategem <gem name>
function mategem {
  # Uncomment this and comment the one bellow if your not using rvm.
  # mate /Library/Ruby/Gems/1.8/gems/`ls /Library/Ruby/Gems/1.8/gems/|grep $1|sort|tail -1`
  mate $rvm_gems_path/$rvm_ruby_string/gems/`ls $rvm_gems_path/$rvm_ruby_string/gems/|grep $1|sort|tail -1`
}

#########
# RAILS #
#########
alias ss="script/server"
alias sc="script/console"
alias sg="script/generate"
alias rdbm="rake db:migrate"
alias rdbc="rake db:create"

#######
# GIT #
#######
alias gc="git commit -m"
alias gs="git status"
alias gp="git push origin master"
alias gb="git branch"