kernel=`uname`

darwin_only() {
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
}

case "$kernel" in
  'Darwin')
    darwin_only
    ;;
esac  

# Setup ruby env
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

PS1='\W$(__git_ps1 " (%s)")\$ '


