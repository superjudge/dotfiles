# (-*- shell-script -*-)

# This file is sourced on all invocations of the shell, unless the -f
# option is set. It should contain commands that set the command search
# path, plus other important environment variables. It should not contain
# commands that produce output or assume the shell is attached to a tty.

# Path to search for autoloadable functions.
fpath=( "$HOME/.zfunc" "$fpath[@]" )
export FPATH
typeset -U fpath

export LC_ALL="en_US.UTF-8"
export LC_TYPE="en_US.UTF-8"
export LANG="en_us.UTF-8"

# Load OS specific settings
[[ $OSTYPE == darwin*  && -f ~/.zsh/darwin/zshenv ]]  && source ~/.zsh/darwin/zshenv
[[ $OSTYPE == linux*   && -f ~/.zsh/linux/zshenv ]]   && source ~/.zsh/linux/zshenv
[[ $OSTYPE == solaris* && -f ~/.zsh/solaris/zshenv ]] && source ~/.zsh/solaris/zshenv
[[ $OSTYPE == freebsd* && -f ~/.zsh/freebsd/zshenv ]] && source ~/.zsh/freebsd/zshenv

# Load host specific settings
[[ -f ~/.zsh/hosts/$HOST/zshenv ]] && source ~/.zsh/hosts/$HOST/zshenv

# Automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath
