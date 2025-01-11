function fw() {
    RG_PREFIX='rg -i --column --line-number --color=always'
    INITIAL_QUERY=''
    fzf --ansi --disabled --query "$INITIAL_QUERY" \
    --bind "start:reload:$RG_PREFIX {q}" \
    --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
    --delimiter : \
    --preview 'bat --style=plain,numbers --color=always  --theme=gruvbox-dark {1} --highlight-line {2}' \
    --preview-window 'right,60%,border-left,+{2}+3/3,~3' \
    --bind 'enter:become(/usr/bin/nvim {1} +{2})'
}

function ff() {
    RG_PREFIX="fd --strip-cwd-prefix --type file"
    INITIAL_QUERY=''
    fzf --ansi --disabled --query "$INITIAL_QUERY" \
    --bind "start:reload:$RG_PREFIX {q}" \
    --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
    --delimiter : \
    --preview 'bat --style=plain,numbers --color=always  --theme=gruvbox-dark {1}' \
    --preview-window 'right,60%,border-left,+{2}+3/3,~3' | sed 's/^\(.*\)$/"\1"/' | xargs -r -n 1 xdg-open
}

function vid() {
    files="$(fd --type=directory --type=file --regex ".mp4|.mkv|.webm")"
    if [ $# -eq 0 ]
    then
        files="$(echo "$files"  | fzf --layout=reverse -i)"
        [[ -f "$files" ]] && mpv $files && vid
    else
        files="$(echo "$files" | grep -i $1)"
        if [[ "$(echo $files | wc -l)" -gt 1 ]]
        then
            files="$(echo $files | fzf --layout=reverse -i)"
            [[ -f "$files" ]] && mpv $files && vid 
        else
            [[ -f "$files" ]] && mpv $files && vid 
        fi 
    fi
}




function mkcd() {
  mkdir -p $@ && cd ${@:$#}
}


function buffer-fzf-history() {
  local HISTORY=$(history -n -r 1 | fzf +m)
  BUFFER=$HISTORY
  if [ -n "$HISTORY" ]; then
    CURSOR=$#BUFFER
  else
    zle accept-line
  fi
}

function slash-backward-kill-word() {
    local WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"
    zle backward-kill-word
}

function zoxide_cd () {
    local dir
    dir=$(zoxide query -i)
    cd -- $dir
    zle reset-prompt
}

zle -N slash-backward-kill-word
zle -N buffer-fzf-history
zle -N zoxide_cd
