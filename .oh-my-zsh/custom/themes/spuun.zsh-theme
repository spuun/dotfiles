function prompt_arch() {
  arch=$(arch)
  if [ ${arch} = 'arm64' ] || [ ${arch} = 'aarch64' ]; then
    echo "💪"
  else
    echo "🤖"
  fi
}


function prompt_username() {
  echo " %n"
}
function prompt_directory() {
  echo " %~"
}
function prompt_git_remote() {
  remote=$(git remote -v 2>/dev/null | head -n 1 | cut -w -f 2) || return
  if [[ $remote =~ http ]]; then
    remote=$(echo $remote | cut -d'/' -f4- | cut -d' ' -f1)
  else
    remote=$(echo $remote | cut -d':' -f2 | cut -d' ' -f1)
  fi
  remote=$(echo $remote | sed 's/.git$//')
  echo "  ${remote}"
}
function prompt_git() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " %{$(parse_git_dirty)%}$(current_branch)%{$reset_color%}$(prompt_git_remote)"
}
function prompt_machine() {
  if [ "$SSH_CONNECTION*" != "*" ]; then
    #echo "R"
    echo "${MACHINE_ICON:-📶}"
  else
    #echo "L"
    echo "${MACHINE_ICON:-%m}"
  fi
}
PROMPT=$'\n''$(prompt_username) $(prompt_machine) $(prompt_directory) $(prompt_git)'$'\n''%(?,%{%F{green}%},%{%F{red}%})#%f '
#PROMPT='$(prompt_machine)$(prompt_arch) $(prompt_username) $(prompt_directory) $(prompt_git) %(?,%{%F{green}%},%{%F{red}%})#%f '
#PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
#PROMPT='%m $(git_prompt_info)%(?,%{$fg[green]%},%{$fg[red]%})#%{$reset_color%} '

# RPS1='%{$fg[blue]%}%~%{$reset_color%} '
#RPS1='$(git_prompt_info) %{$fg_bold[blue]%}%10>…>%m%{$reset_color%}%{$reset_color%}'
#RPS1='$(prompt_machine)'

#ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[yellow]%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
