# This file is sourced when a login shell exits.

# Load OS specific settings
[[ $OSTYPE == darwin*  && -f ~/.zsh/darwin/zlogout ]]  && source ~/.zsh/darwin/zlogout
[[ $OSTYPE == linux*   && -f ~/.zsh/linux/zlogout ]]   && source ~/.zsh/linux/zlogout
[[ $OSTYPE == solaris* && -f ~/.zsh/solaris/zlogout ]] && source ~/.zsh/solaris/zlogout
[[ $OSTYPE == freebsd* && -f ~/.zsh/freebsd/zlogout ]] && source ~/.zsh/freebsd/zlogout

# Load host specific settings
[[ -f ~/.zsh/hosts/$HOST/zlogout ]] && source ~/.zsh/hosts/$HOST/zlogout
