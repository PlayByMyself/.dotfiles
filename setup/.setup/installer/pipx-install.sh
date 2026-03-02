#!/bin/bash

BASE_PYTHON_PACKAGE_LIST=(
    tldr
)

DEVELOP_PYTHON_PACKAGE_LIST=(
    poetry
)

SERVER_PYTHON_PACKAGE_LIST=()

if [[ $1 = "dev" ]]; then
    pipx install ${BASE_PYTHON_PACKAGE_LIST[@]} ${DEVELOP_PYTHON_PACKAGE_LIST[@]}
elif [[ $1 = "server" ]]; then
    pipx install ${BASE_PYTHON_PACKAGE_LIST[@]} ${SERVER_PYTHON_PACKAGE_LIST[@]}
else
    echo "Usage: $0 [dev|server]"
fi
