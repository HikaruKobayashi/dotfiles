# 環境変数

# rbenv
status --is-interactive; and source (rbenv init -|psub)

# pyenv
set PATH $HOME/.pyenv $PATH
eval (pyenv init - | source)

# nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH
