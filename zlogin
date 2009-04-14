# (-*- shell-script -*-)

# This file is sourced in login shells. It should contain commands that should
# be executed only in login shells.

print
fortune
print

# Load OS specific settings
[[ $OSTYPE == darwin*  && -f ~/.zsh/darwin/zlogin ]]  && source ~/.zsh/darwin/zlogin
[[ $OSTYPE == linux*   && -f ~/.zsh/linux/zlogin ]]   && source ~/.zsh/linux/zlogin
[[ $OSTYPE == solaris* && -f ~/.zsh/solaris/zlogin ]] && source ~/.zsh/solaris/zlogin
[[ $OSTYPE == freebsd* && -f ~/.zsh/freebsd/zlogin ]] && source ~/.zsh/freebsd/zlogin

# Load host specific settings
[[ -f ~/.zsh/hosts/$HOST/zlogin ]] && source ~/.zsh/hosts/$HOST/zlogin
