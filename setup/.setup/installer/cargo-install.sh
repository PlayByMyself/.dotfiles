#!/bin/bash

export PATH="$PATH:$HOME/.cargo/bin"

BASE_RUST_PACAKGE_LIST=(
    sheldon
    fnm
)

DEVELOP_RUST_PACAKGE_LIST=(
    cargo-edit
)

SERVER_RUST_PACAKGE_LIST=()

rustup_init() {
    if type rustup >/dev/null 2>&1; then
        rustup update stable
    else
        curl https://sh.rustup.rs -sSf | sh -s -- -y
        # First time install need remove .zshenv, it will be stowed after
        if [[ -f ~/.zshenv ]]; then
            rm ~/.zshenv
        fi
    fi
}

if [[ $1 == "dev" ]]; then
    rustup_init
    cargo install ${BASE_RUST_PACAKGE_LIST[@]} ${DEVELOP_RUST_PACAKGE_LIST[@]}
elif [[ $1 == "server" ]]; then
    rustup_init
    cargo install ${BASE_RUST_PACAKGE_LIST[@]} ${SERVER_RUST_PACAKGE_LIST[@]}
else
    echo "Usage: $0 [dev|server]"
fi
