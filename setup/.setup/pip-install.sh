#!/bin/sh

BASE_PYTHON_PACKAGE_LIST=(
    tldr
)

DEVELOP_PYTHON_PACKAGE_LIST=(
    poetry
)

SERVER_PYTHON_PACKAGE_LIST=()

pip_init() {
    if type pip >/dev/null 2>&1; then
        PIP_COMMAND="pip"
    elif type pip3 >/dev/null 2>&1; then
        PIP_COMMAND="pip3"
    else
        python3 -m ensurepip || curl https://bootstrap.pypa.io/get-pip.py | python3
        PIP_COMMAND="pip3"
    fi
}

pip_init

if [[ $1 = "dev" ]]; then
    $PIP_COMMAND install --user ${BASE_PYTHON_PACKAGE_LIST[@]} ${DEVELOP_PYTHON_PACKAGE_LIST[@]}
elif [[ $1 = "server" ]]; then
    $PIP_COMMAND install --user ${BASE_PYTHON_PACKAGE_LIST[@]} ${SERVER_PYTHON_PACKAGE_LIST[@]}
else
    echo "Usage: $0 [dev|server]"
fi
