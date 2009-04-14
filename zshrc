# (-*- shell-script -*-)

# This file is sourced in interactive shells. It should contain commands
# to set up aliases, functions, options, key bindings, etc.

source ~/.zsh/aliases
source ~/.zsh/options
source ~/.zsh/keybindings
source ~/.zsh/functions

# Setup virtualenv wrapper
export WORKON_HOME=$HOME/.virtualenvs
source ~/bin/virtualenvwrapper_bashrc

# Load OS specific settings
[[ $OSTYPE == darwin*  && -f ~/.zsh/darwin/zshrc ]]  && source ~/.zsh/darwin/zshrc
[[ $OSTYPE == linux*   && -f ~/.zsh/linux/zshrc ]]   && source ~/.zsh/linux/zshrc
[[ $OSTYPE == solaris* && -f ~/.zsh/solaris/zshrc ]] && source ~/.zsh/solaris/zshrc
[[ $OSTYPE == freebsd* && -f ~/.zsh/freebsd/zshrc ]] && source ~/.zsh/freebsd/zshrc

# Load host specific settings
[[ -f ~/.zsh/hosts/$HOST/zshrc ]] && source ~/.zsh/hosts/$HOST/zshrc
