
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -FG --color=auto'
alias ll='ls -l'

# Setup starship
eval "$(starship init zsh)"

[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh
[ -d "$HOME/go/bin" ] && export PATH=$PATH:"$HOME/go/bin"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin":$PATH
[ -f "/home/mjl/.ghcup/env" ] && source "/home/mjl/.ghcup/env" # ghcup-env

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
