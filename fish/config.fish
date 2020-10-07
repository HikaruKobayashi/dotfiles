# -----------------------
# Environment Variable
# -----------------------

# rbenv
status --is-interactive; and source (rbenv init -|psub)
set -x OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES

# pyenv
set -x PATH $HOME/.pyenv $PATH
eval (pyenv init - | source)

# nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH
