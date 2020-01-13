kernel=`uname`
export LC_ALL=en_US.UTF-8

if [[ ":$PATH:" != *":/usr/local/sbin:"* ]]; then
  export PATH=$PATH:/usr/local/sbin
fi

if [[ -d "$HOME/.bin" ]]; then
  export PATH=$HOME/.bin:$PATH
fi

if [[ -d "$HOME/code/tools/bin" ]]; then
  export PATH=$PATH:$HOME/code/tools/bin
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

ssh() {
  [ -n "$TMUX" ] && tmux rename-window "${@: -1}"
  /usr/local/bin/ssh "$@"
  [ -n "$TMUX" ] && tmux setw automatic-rename
}

darwin_only() {
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi

  alias git=hub
  gpp() {
    git push origin && git push heroku
  }
  gppl() {
    gpp && heroku logs -t
  }

  export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"
}

ubuntu_only()
{
  killall ssh-agent > /dev/null 2>&1
  eval $(ssh-agent -s) > /dev/null 2>&1
}

case "$kernel" in
  'Darwin')
    darwin_only
    ;;
  'Linux')
    case `lsb_release -i -s` in
      'Ubuntu')
        ubuntu_only
        ;;
    esac
    ;;
esac  

# Setup ruby env
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

PS1='\W$(__git_ps1 " (%s)")\$ '


if [ -f $HOME/.env_vars ]; then
  source $HOME/.env_vars
fi

function rmb {
  current_branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  if [ "$current_branch" != "master" ]; then
    echo "WARNING: You are on branch $current_branch, NOT master."
  fi
  echo "Fetching merged branches..."
  git remote prune origin
  remote_branches=$(git branch -r --merged | grep -v '/master$' | grep -v "/$current_branch$")
  local_branches=$(git branch --merged | grep -v 'master$' | grep -v "$current_branch$")
  if [ -z "$remote_branches" ] && [ -z "$local_branches" ]; then
    echo "No existing branches have been merged into $current_branch."
  else
    echo "This will remove the following branches:"
    if [ -n "$remote_branches" ]; then
      echo "$remote_branches"
    fi
    if [ -n "$local_branches" ]; then
      echo "$local_branches"
    fi
    read -p "Continue? (y/n): " -n 1 choice
    echo
    if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
      # Remove remote branches
      git push origin `git branch -r --merged | grep -v '/master$' | grep -v "/$current_branch$" | sed 's/origin\//:/g' | tr -d '\n'`
      # Remove local branches
      git branch -d `git branch --merged | grep -v 'master$' | grep -v "$current_branch$" | sed 's/origin\///g' | tr -d '\n'`
    else
      echo "No branches removed."
    fi
  fi
}
function gitall {
  for dir in `ls -1`; do
    if [ -d "$dir/.git" ]; then
      pushd . 1>/dev/null
      cd $dir
      git $* | xargs -L1 echo [$dir]
      popd 1>/dev/null
    fi
  done
}

if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
function test-port4 {
  nc -4vz $*
}
function test-port6 {
  nc -6vz $*
}
function test-ssl4 {
  openssl s_client -showcerts -4 -connect $* </dev/null
}
function test-ssl6 {
  openssl s_client -showcerts -6 -connect $* </dev/null
}
function queuehash {
  erl -noshell -eval "<<Num:128>> = erlang:md5(term_to_binary({resource,<<\"$1\">>,queue,<<\"$2\">>})), io:format(\"~.36B~n\", [Num]), init:stop()."
}
function ssl-cert-exp {
  test-ssl4 $* 2>/dev/null | openssl x509 -enddate -noout
}

EDITOR="vim"
