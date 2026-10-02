function fzfprv {
  fzf --ansi \
      --color 'hl:-1:underline,hl+:-1:underline:reverse' \
      --delimiter ':' \
      --preview "bat --color=always {1} --theme='Visual Studio Dark+' --highlight-line {2}" \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
      "$@"
}

function frg {
  local result=$(rg --ignore-case --color=always --line-number --no-heading "$@" | fzfprv)

  local file="${result%%:*}"

  local linenumber=`echo "${result}" | cut -d: -f2`

  if [ ! -z "$file" ]; then
    $EDITOR +"${linenumber}" "$file"
  fi
}

function fgl {
  git log --color=always \
    --format='%H %C(yellow)%h%C(reset) %s %C(green)(%cr) %C(blue)%an%C(reset)' \
    "$@" |
    fzf --ansi \
      --no-sort \
      --delimiter=' ' \
      --with-nth='2..' \
      --color='hl:-1:underline,hl+:-1:underline:reverse' \
      --preview='git show --color=always --stat --patch {1} | delta --paging=never' \
      --preview-window='right,60%,border-left' \
      --bind='enter:execute(git show --color=always --stat --patch {1} | delta --paging=always)' \
      --bind='ctrl-y:execute-silent(printf %s {1} | wl-copy)'
}

function ffrg {
  local query="${1:-}"
  local search_path="${2:-.}"

  local result=$(rg --line-number --no-heading --color=always -- '' "$search_path" |
    fzfprv --nth='3..' --query="$query")

  local file="${result%%:*}"

  local linenumber=`echo "${result}" | cut -d: -f2`

  if [ ! -z "$file" ]; then
    $EDITOR +"${linenumber}" "$file"
  fi
}
