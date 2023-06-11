# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Setup completions for asdf
fpath=("$HOME/.asdf/completions" $fpath)

autoload -Uz compinit bashcompinit
compinit
bashcompinit

set -o emacs

setopt completeinword
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

# export EDITOR=lvim
export EDITOR=vi
export ALTERNATE_EDITOR=""
alias e="emacsclient --tty"
alias ev="emacsclient --create-frame"

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

[[ -d "$HOME/.local/share/nvim-linux64/bin" ]] && export PATH="$HOME/.local/share/nvim-linux64/bin":$PATH
# [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
# [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh
[ -d "/usr/local/go/bin" ] && export PATH=$PATH:/usr/local/go/bin
[ -d "$HOME/.emacs.d/bin" ] && export PATH=$PATH:"$HOME/.emacs.d/bin"
[ -d "$HOME/.rd/bin" ] && export PATH="$HOME/.rd/bin":$PATH
[ -d "$HOME/go/bin" ] && export PATH=$PATH:"$HOME/go/bin"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin":$PATH
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
#[ -f "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"
# [[ -f "$HOME/.rye/env" ]] && source "$HOME/.rye/env"
[ -d "$HOME/.nimble/bin" ] && export PATH=$PATH:"$HOME/.nimble/bin"
[[ -d "$HOME/.pyenv/bin" ]] && export PATH="$HOME/.pyenv/bin:$PATH" && eval "$(pyenv init -)"
# opam configuration
[[ ! -r /home/mjl/.opam/opam-init/init.zsh ]] || source /home/mjl/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
[[ -f "$HOME/.asdf/asdf.sh" ]] && . "$HOME/.asdf/asdf.sh"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
