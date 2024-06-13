if [[ -f $HOME/.pyenv/bin/pyenv && ! -n $PYENV_SHELL ]]; then
    add_path $HOME/.pyenv/bin
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
