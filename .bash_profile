#SSH and Bitbucket/git config
SSH_ENV=$HOME/.ssh/environment
   
# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}
                             
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi


#12-9-14 helper stuff to check out a git feature branch, using incroud naming conventions.

export FI='feature/ICR'
  

#12-8-14 git autocomplete
source ~/git-completion.bash


# go to correct dir and start vagrant
function incroudgo {
  cd /Users/dev/projects/incroud.com
  vagrant up
  vagrant ssh
}

#TODO
#Make running tests with mocha easier, for node.js / incroud infrastructure repo

#Set my command prompt to just show cur directory
#To reset to original change settings to: \h:\W \u\$
export PS1='\W $ '

#Aliases for cassandra db to make life easy - July 20 2014
alias start-cassandra='launchctl load /usr/local/opt/cassandra/homebrew.mxcl.cassandra.plist'
alias start-cqlsh='cqlsh -u cassandra -p cassandra'


#Make using entr easier, syntax: 'rentr filename executable'
rentr(){
  find . -name $1 | entr -c $2 $1
}

#Function for using entr to make life easier
#NOTE WORKING AS OF 7-21-14
run-entr-node(){
  if [$2 == "all"] 
  then
    find . -name $1 | entr -c node $1
  else 
    find . *.js | entr -c node $1
  fi
}

alias run-entr-node=run-entr-node

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export NVM_DIR="/Users/dev/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
