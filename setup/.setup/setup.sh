#!/bin/sh

BASE_PACKAGE_LIST=(
    zsh
    stow
    git
    python3
    wget
    curl
    screen
)

DEVELOP_PACKAGE_LIST=()

SERVER_PACKAGE_LIST=(
    fail2ban
)

EXTRA_INSTALLER_LIST=(
    cargo-install.sh
    pip-install.sh
)

init_package_manager() {
    # FreeBSD
    if type -p pkg >/dev/null; then
        MANAGER_COMMAND="pkg"
        MANAGER_INSTALL="install -y"
        MANAGER_UPDATE="update"
        MANAGER_PACKAGE_LIST=()
    # Ubuntu
    elif type -p apt-get >/dev/null; then
        MANAGER_COMMAND="apt-get"
        MANAGER_INSTALL="install -y"
        MANAGER_UPDATE="update"
        MANAGER_PACKAGE_LIST=(
            libssl-dev
        )
    # CentOS
    elif type -p yum >/dev/null; then
        MANAGER_COMMAND="yum"
        MANAGER_INSTALL="install -y"
        MANAGER_UPDATE="makecache"
        MANAGER_PACKAGE_LIST=(
            openssl-devel
        )
    # Arch
    elif type -p pacman >/dev/null; then
        MANAGER_COMMAND="pacman"
        MANAGER_INSTALL="-S"
        MANAGER_UPDATE="-Syu"
        MANAGER_PACKAGE_LIST=()
    # Openwrt
    elif type -p opkg >/dev/null; then
        MANAGER_COMMAND="opkg"
        MANAGER_INSTALL="install"
        MANAGER_UPDATE="update"
        MANAGER_PACKAGE_LIST=()
    # Rest
    else
        echo "Unsupported package manager"
        exit 1
    fi
}

init_sheldon() {
    if [[ ! -d ~/.sheldon ]]; then
        mkdir ~/.sheldon
    fi
}

init_package_manager
init_sheldon
if [ "$1" = "dev" ]; then
    sudo $MANAGER_COMMAND $MANAGER_UPDATE
    sudo $MANAGER_COMMAND $MANAGER_INSTALL \
        ${BASE_PACKAGE_LIST[@]} ${DEVELOP_PACKAGE_LIST[@]} ${MANAGER_PACKAGE_LIST[@]}
    for installer in ${EXTRA_INSTALLER_LIST[@]}; do
        sh $(dirname $0)/installer/$installer dev
    done
elif [ "$1" = "server" ]; then
    sudo $MANAGER_COMMAND $MANAGER_UPDATE
    sudo $MANAGER_COMMAND $MANAGER_INSTALL \
        ${BASE_PACKAGE_LIST[@]} ${SERVER_PACKAGE_LIST[@]} ${MANAGER_PACKAGE_LIST[@]}
    for installer in ${EXTRA_INSTALLER_LIST[@]}; do
        sh $(dirname $0)/installer/$installer server
    done
else
    echo "Usage: $0 [dev|server]"
fi
