# vim:et sts=2 sw=2 ft=zsh
#
# s1ck94 theme
#
# Implemented after the now extinct version of minimal by S1cK94.
#
# Requires the `git-info` zmodule to be included in the .zimrc file.

_prompt_s1ck94_vimode() {
  case ${KEYMAP} in
    main|viins) print -n "%F{${ON_COLOR}}" ;;
    *) print -n "%F{${OFF_COLOR}}" ;;
  esac
  print -n ${PROMPT_CHAR}
}

_prompt_s1ck94_pwd() {
  local separator='%F{244}/%f'
  local current_dir="${PWD/#${HOME}/~}"
  if [[ ${current_dir} != '~' ]]; then
    # Can't use ${separator} with curly braces below. See Parameter Expansion Flags in zshexpn(1)
    current_dir="${${(@pj:$separator:M)${(@s:/:)current_dir:h}#?}%/}${separator}${current_dir:t}"
  fi
  print -n ${current_dir}
}

function zle-line-init zle-keymap-select {
  zle reset-prompt
  zle -R
}

() {
  : ${PROMPT_CHAR=❯}
  : ${ON_COLOR=green}
  : ${OFF_COLOR=default}
  : ${ERR_COLOR=red}
  local user_prompt='%F{%(!.${ON_COLOR}.${OFF_COLOR})}${PROMPT_CHAR}'
  local jobs_prompt='%F{%(1j.${ON_COLOR}.${OFF_COLOR})}${PROMPT_CHAR}'
  local status_prompt='%F{%(0?.${ON_COLOR}.${ERR_COLOR})}${PROMPT_CHAR}'

  zle -N zle-line-init
  zle -N zle-keymap-select

  setopt nopromptbang promptcr promptpercent promptsp promptsubst

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

  PS1="${user_prompt}${jobs_prompt}\$(_prompt_s1ck94_vimode)${status_prompt}%f "
  RPS1='$(_prompt_s1ck94_pwd)${(e)git_info[rprompt]}%f'
}
