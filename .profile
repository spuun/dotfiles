
kernel=`uname`

export LC_ALL=en_US.UTF-8
export HISTCONTROL=ignorespace
export EDITOR=vim

if [ -f $HOME/.env_vars ]; then
  source $HOME/.env_vars
fi


# Setup ruby env (this will update PATH)
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


if [[ ":$PATH:" != *":/usr/local/sbin:"* ]]; then
  export PATH=$PATH:/usr/local/sbin
fi

if [ $(arch) = 'arm64' ]; then
  if [ -d "/opt/homebrew/bin" ] && [[ ":$PATH:" != *":/opt/homebrew/bin:"* ]]; then
    export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
  fi
else
  if [ -d "/usr/local/Homebrew" ] && [[ ":$PATH:" != *":/usr/local/Homebrew/bin:"* ]]; then
    export PATH=/usr/local/Homebrew/bin:$PATH
  fi
fi

if [[ -d "$HOME/84codes/tools/bin" ]]; then
  export PATH=$PATH:$HOME/84codes/tools/bin
fi

if [[ -d "$HOME/code/tools/bin" ]]; then
  export PATH=$PATH:$HOME/code/tools/bin
fi

if [[ -d "$HOME/.bin" ]]; then
  export PATH=$HOME/.bin:$PATH
fi

# Lazy init NVM
function nvm() {
  if [ -d "$HOME/.nvm" ]; then
    unset -f nvm
    command -v nvm 2>&1 > /dev/null
    if [ $? != 0 ]; then
      export NVM_DIR="$HOME/.nvm"
      echo "Loading nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
      echo "Loaded nvm"
    fi
    nvm $*
  else
    echo "nvm not installed?"
  fi
}

function npm() {
  unset -f npm
  command -v npm 2>&1 > /dev/null
  if [ $? != 0 ]; then
    nvm
  fi
  npm $*
}


darwin_only() {
  alias git=hub
  gpp() {
    git push origin && git push heroku
  }
  gppl() {
    gpp && heroku logs -t
  }

  alias intel='arch -x86_64 zsh'

  export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"
}

ubuntu_only() {
  echo "Nothing"
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
function ssl-cert-exp {
  test-ssl4 $* 2>/dev/null | openssl x509 -enddate -noout
}

alias tmux='tmux -u'


EDITOR="vim"
echo "Profile loaded."
