
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

autoload -Uz compinit bashcompinit
compinit
bashcompinit

setopt completeinword
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

export EDITOR=lvim

HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000
setopt sharehistory
setopt extendedhistory
setopt interactivecomments # pound sign in interactive prompt

setopt auto_cd

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
