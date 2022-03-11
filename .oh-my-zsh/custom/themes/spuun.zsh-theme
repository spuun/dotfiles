PROMPT='%3~ $(git_prompt_info) %(?,%F{green},%F{red})#%f '
#PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
#PROMPT='%m $(git_prompt_info)%(?,%{$fg[green]%},%{$fg[red]%})#%{$reset_color%} '

# RPS1='%{$fg[blue]%}%~%{$reset_color%} '
#RPS1='$(git_prompt_info) %{$fg_bold[blue]%}%10>…>%m%{$reset_color%}%{$reset_color%}'
RPS1='%n@%m'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{green}!"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}!"
