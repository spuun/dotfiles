if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Setup ruby env
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

PS1='\W$(__git_ps1 " (%s)")\$ '


