#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -FG --color=auto'
alias ll='ls -l'

# Setup starship
eval "$(starship init bash)"

[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh
[ -d "$HOME/go/bin" ] && export PATH=$PATH:"$HOME/go/bin"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin":$PATH
[ -d "$HOME/.emacs.d/bin" ] && export PATH=$PATH:"$HOME/.emacs.d/bin"
[ -d "$HOME/.rd/bin" ] && export PATH="$HOME/.rd/bin":$PATH
[ -f "/home/mjl/.ghcup/env" ] && source "/home/mjl/.ghcup/env" # ghcup-env

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
