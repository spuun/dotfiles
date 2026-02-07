
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

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
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
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    fi
    if [ $# -gt 0 ]; then
      nvm $*
    fi
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

nvm

#alias tmux='tmux -u'

alias vim=nvim
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="nvim"
export CRYSTAL_OPTS="-Dpreview_mt -Dexecution_context"
alias dotfiles="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
echo "Profile loaded."
