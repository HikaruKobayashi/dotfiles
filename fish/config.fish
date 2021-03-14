# -----------------------
# Environment Variable
# -----------------------

set PATH /usr/local/bin /usr/sbin $PATH

# rbenv
status --is-interactive; and source (rbenv init -|psub)
set -x OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES

# pyenv
set -x PATH $HOME/.pyenv $PATH
eval (pyenv init - | source)

# nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH

# goenv
set -x GOENV_ROOT $HOME/.goenv
set -x PATH $GOENV_ROOT/bin $PATH
eval (goenv init - | source)
set -x PATH $GOPATH/bin $PATH