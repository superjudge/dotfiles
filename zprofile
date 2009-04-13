# This file is similar to .zlogin, except it is sourced before .zshrc.
# It is meant as an alternative to .zlogin (especially for ksh fans); the
# two are not meant to be used together (event though they could be).

# INTENTIONALLY LEFT EMPTY (as we use .zlogin)

# Load OS specific settings
[[ $OSTYPE == darwin*  && -f ~/.zsh/darwin/zprofile ]]  && source ~/.zsh/darwin/zprofile
[[ $OSTYPE == linux*   && -f ~/.zsh/linux/zprofile ]]   && source ~/.zsh/linux/zprofile
[[ $OSTYPE == solaris* && -f ~/.zsh/solaris/zprofile ]] && source ~/.zsh/solaris/zprofile
[[ $OSTYPE == freebsd* && -f ~/.zsh/freebsd/zprofile ]] && source ~/.zsh/freebsd/zprofile

# Load host specific settings
[[ -f ~/.zsh/hosts/$HOST/zprofile ]] && source ~/.zsh/hosts/$HOST/zprofile
