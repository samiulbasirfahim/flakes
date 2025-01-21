alias xqd='xbps-query -R'         
alias xqf='xbps-query -f'         
alias xql='xbps-query -l'         
alias xqrs='xbps-query -Rs'       
alias xqs='xbps-query -s'         
alias xis='sudo xbps-install -S'  
alias xiu='sudo xbps-install -Su' 
alias xrr='sudo xbps-remove -Ro'  
alias xbr="sudo xbps-remove -RoO"


alias cat="bat --style=full --theme=gruvbox-dark"
alias ls="eza -T --icons=always --level=1"
alias lsa="ls --all"
alias lst="eza -T --icons=always"
alias nv="nvim"
alias rec="ffmpeg -video_size 1920x1080 -framerate 60 -f x11grab -i :0.0 "
alias emc="emacsclient -c"

alias grep="grep --color=auto"

alias dotgit="git --git-dir=$HOME/.dots/ --work-tree=$HOME"

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias ......='../../../../..'
