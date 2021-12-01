#!/bin/sh

BASE_PACKAGE_LIST=(
    zsh
    stow
    git
    python3
)

DEVELOP_PACKAGE_LIST=()

SERVER_PACKAGE_LIST=(
    fail2ban
)

init_package_manager() {
    # FreeBSD
    if type -p pkg >/dev/null; then
        MANAGER_COMMAND="pkg"
        MANAGER_INSTALL="install -y"
        MANAGER_UPDATE="update"
    # Ubuntu
    elif type -p apt-get >/dev/null; then
        MANAGER_COMMAND="apt-get"
        MANAGER_INSTALL="install -y"
        MANAGER_UPDATE="update"
    # CentOS
    elif type -p yum >/dev/null; then
        MANAGER_COMMAND="yum"
        MANAGER_INSTALL="install -y"
        MANAGER_UPDATE="makecache"
    # Arch
    elif type -p pacman >/dev/null; then
        MANAGER_COMMAND="pacman"
        MANAGER_INSTALL="-S"
        MANAGER_UPDATE="-Syy"
    # Openwrt
    elif type -p opkg >/dev/null; then
        MANAGER_COMMAND="opkg"
        MANAGER_INSTALL="install"
        MANAGER_UPDATE="update"
    # Rest
    else
        echo "Unsupported package manager"
        exit 1
    fi
}

package_manager_update() {
    $MANAGER_COMMAND $MANAGER_UPDATE
}

package_manager_install() {
    local PACKAGE_NAME=$1
    if type -p $PACKAGE_NAME >/dev/null; then
        echo "$PACKAGE_NAME is already installed"
        return
    else
        echo "Installing package $PACKAGE_NAME"
        $MANAGER_COMMAND $MANAGER_INSTALL $PACKAGE_NAME
    fi
}

init_package_manager
if [ "$1" = "update" ]; then
    package_manager_update
elif [ "$1" = "install" ]; then
    for BASE_PACKAGE in ${BASE_PACKAGE_LIST[@]}; do
        package_manager_install $BASE_PACKAGE
    done
    for DEVELOP_PACKAGE in ${DEVELOP_PACKAGE_LIST[@]}; do
        package_manager_install $DEVELOP_PACKAGE
    done
elif [ "$1" = "install-server" ]; then
    for BASE_PACKAGE in ${BASE_PACKAGE_LIST[@]}; do
        package_manager_install $BASE_PACKAGE
    done
    for SERVER_PACKAGE in ${SERVER_PACKAGE_LIST[@]}; do
        package_manager_install $SERVER_PACKAGE
    done
else
    echo "Usage: $0 [update|install|install-server]"
fi
