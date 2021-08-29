# vim:et sts=2 sw=2 ft=zsh
#
# s1ck94 theme
#
# Implemented after the now extinct version of minimal by S1cK94.
#
# Requires the `prompt-pwd` and `git-info` zmodules to be included in the .zimrc file.

_prompt_s1ck94_vimode() {
  case ${KEYMAP} in
    vicmd) print -n "%F{${OFF_COLOR}}" ;;
    *) print -n "%F{${ON_COLOR}}" ;;
  esac
  print -n ${PROMPT_CHAR}
}

_prompt_s1ck94_keymap_select() {
  zle reset-prompt
  zle -R
}
if autoload -Uz is-at-least && is-at-least 5.3; then
  autoload -Uz add-zle-hook-widget && \
      add-zle-hook-widget -Uz keymap-select _prompt_s1ck94_keymap_select
else
  zle -N zle-keymap-select _prompt_s1ck94_keymap_select
fi

if (( ! ${+PROMPT_CHAR} )) typeset -g PROMPT_CHAR=❯
if (( ! ${+ON_COLOR} )) typeset -g ON_COLOR=green
if (( ! ${+OFF_COLOR} )) typeset -g OFF_COLOR=default
if (( ! ${+ERR_COLOR} )) typeset -g ERR_COLOR=red

setopt nopromptbang prompt{cr,percent,sp,subst}

zstyle ':zim:prompt-pwd:fish-style' dir-length 1
zstyle ':zim:prompt-pwd:separator' format '%F{244}/%f'

typeset -gA git_info
if (( ${+functions[git-info]} )); then
  zstyle ':zim:git-info:branch' format '%b'
  zstyle ':zim:git-info:commit' format '%c'
  zstyle ':zim:git-info:dirty' format '%F{${ERR_COLOR}}'
  zstyle ':zim:git-info:diverged' format '%F{${ERR_COLOR}}'
  zstyle ':zim:git-info:behind' format '%F{yellow}'
  zstyle ':zim:git-info:ahead' format '%F{${OFF_COLOR}}'
  zstyle ':zim:git-info:keys' format \
      'rprompt' ' $(coalesce %D %V %B %A %F{${ON_COLOR}})%b%c'

  autoload -Uz add-zsh-hook && add-zsh-hook precmd git-info
fi

local prompt_fmt=('%F{%(' '.${ON_COLOR}.' ')}${PROMPT_CHAR}')
local user_param=('!'  '${OFF_COLOR}' '')
local jobs_param=('1j' '${OFF_COLOR}' '')
local stat_param=('0?' '${ERR_COLOR}' '')

PS1="${(@j::)prompt_fmt:^user_param}${(@j::)prompt_fmt:^jobs_param}\$(_prompt_s1ck94_vimode)${(@j::)prompt_fmt:^stat_param}%f "
RPS1='$(prompt-pwd)${(e)git_info[rprompt]}%f'

unset prompt_fmt user_param jobs_param stat_param
