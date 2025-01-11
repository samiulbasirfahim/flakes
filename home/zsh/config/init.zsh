source ~/.config/zsh/config/init.zsh
source ~/.config/zsh/functions/init.zsh
source ~/.config/zsh/plugins/init.zsh



if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
    exec startx
fi


