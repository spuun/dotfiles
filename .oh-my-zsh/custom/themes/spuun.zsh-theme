function prompt_arch() {
  if [ $(arch) = 'arm64' ]; then
    echo "💪"
  else
    echo "🤖"
  fi
}
function prompt_ssh() {
  if [ -n $SSH_CONNECTION ]; then
    echo "📶"
  fi
}
function prompt_username() {
  echo "%n"
}
function prompt_directory() {
  echo "%~"
}
PROMPT='$(prompt_ssh)$(prompt_arch) $(prompt_username) $(prompt_directory) $(git_prompt_info) %(?,%F{green},%F{red})#%f '
#PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
#PROMPT='%m $(git_prompt_info)%(?,%{$fg[green]%},%{$fg[red]%})#%{$reset_color%} '

# RPS1='%{$fg[blue]%}%~%{$reset_color%} '
#RPS1='$(git_prompt_info) %{$fg_bold[blue]%}%10>…>%m%{$reset_color%}%{$reset_color%}'
RPROMPT='%m'

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="🟢"
ZSH_THEME_GIT_PROMPT_DIRTY="🔴"
