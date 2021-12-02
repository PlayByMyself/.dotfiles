# proxy
alias proxy="source ~/.proxy.sh"

# cargo
if [ -f ~/.cargo/env ]; then
    source ~/.cargo/env
fi

# user pip
PATH=$PATH:$HOME/.local/bin

# pyenv
PATH="/home/yejun/.pyenv/bin:$PATH"
if type -p pyenv >/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# vitasdk
export VITASDK=/usr/local/vitasdk
PATH=$VITASDK/bin:$PATH

# go
PATH=$PATH:/usr/local/go/bin
PATH="$HOME/go/bin:$PATH"

# wasmtime
export WASMTIME_HOME="$HOME/.wasmtime"
PATH="$WASMTIME_HOME/bin:$PATH"
