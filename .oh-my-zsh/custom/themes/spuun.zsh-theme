function prompt_arch() {
  if [ $(arch) = 'arm64' ]; then
    echo "💪"
  else
    echo "🤖"
  fi
}
function prompt_ssh() {
  if [ "$SSH_CONNECTION*" != "*" ]; then
    echo "📶"
  fi
}
function prompt_username() {
  echo "%n"
}
function prompt_directory() {
  echo "%~"
}
function prompt_git() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$(parse_git_dirty)$(current_branch)$reset_color"
}
PROMPT='$(prompt_ssh)$(prompt_arch) $(prompt_username) $(prompt_directory) $(prompt_git) %(?,%F{green},%F{red})#%f '
#PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
#PROMPT='%m $(git_prompt_info)%(?,%{$fg[green]%},%{$fg[red]%})#%{$reset_color%} '

# RPS1='%{$fg[blue]%}%~%{$reset_color%} '
#RPS1='$(git_prompt_info) %{$fg_bold[blue]%}%10>…>%m%{$reset_color%}%{$reset_color%}'
RPROMPT='%m'

#ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[yellow]%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]"
