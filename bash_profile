#SSH and Bitbucket/git config
SSH_ENV=$HOME/.ssh/environment

#Environment variables
export VISUAL=/usr/local/bin/vim
export EDITOR=/usr/local/bin/vim

#Helper function for naming terminal windows
#Use: >title my title
function title {
    echo -ne "\033]0;"$*"\007"
}


#11/9/15
#scmPuff - git ui sugar tool - load aliases
#eval "$(scmpuff init -s)"

#Set my command prompt to just show cur directory
#To reset to original change settings to: \h:\W \u\$
export PS1='\W $ '


#Make using entr easier, syntax: 'rentr filename executable'
rentr(){
  find . -name $1 | entr -c $2 $1
}

#Entr shortcut for cairneche
cairneche(){
    find ./web/static/js/ | entr sh -c './scripts/package_js.sh && ./scripts/deploy_js.sh'
}

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

# node version manager
#export NVM_DIR="$HOME/.nvm"
#. "$(brew --prefix nvm)/nvm.sh"

#test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
#export PATH="/usr/local/sbin:$PATH"

### Aliases for nginx ###
### From: https://blog.frd.mn/install-nginx-php-fpm-mysql-and-phpmyadmin-on-os-x-mavericks-using-homebrew/
#alias nginx.start='sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.nginx.plist'
#alias nginx.stop='sudo launchctl unload /Library/LaunchDaemons/homebrew.mxcl.nginx.plist'
#alias nginx.restart='nginx.stop && nginx.start'
#alias php-fpm.start="launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php56.plist"
#alias php-fpm.stop="launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.php56.plist"
#alias php-fpm.restart='php-fpm.stop && php-fpm.start'
#alias mysql.start="launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist"
#alias mysql.stop="launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist"
#alias mysql.restart='mysql.stop && mysql.start'
#alias nginx.logs.error='tail -250f /usr/local/etc/nginx/logs/error.log'
#alias nginx.logs.access='tail -250f /usr/local/etc/nginx/logs/access.log'
#alias nginx.logs.default.access='tail -250f /usr/local/etc/nginx/logs/default.access.log'
#alias nginx.logs.default-ssl.access='tail -250f /usr/local/etc/nginx/logs/default-ssl.access.log'
#alias nginx.logs.phpmyadmin.error='tail -250f /usr/local/etc/nginx/logs/phpmyadmin.error.log'
#alias nginx.logs.phpmyadmin.access='tail -250f /usr/local/etc/nginx/logs/phpmyadmin.access.log'
