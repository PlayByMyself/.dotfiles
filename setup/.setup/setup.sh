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
        MANAGER_UPDATE="-Syy"
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
    $MANAGER_COMMAND $MANAGER_UPDATE
elif [ "$1" = "install" ]; then
    $MANAGER_COMMAND $MANAGER_INSTALL $BASE_PACKAGE_LIST $DEVELOP_PACKAGE_LIST $MANAGER_PACKAGE_LIST
elif [ "$1" = "install-server" ]; then
    $MANAGER_COMMAND $MANAGER_INSTALL $BASE_PACKAGE_LIST $SERVER_PACKAGE_LIST $MANAGER_PACKAGE_LIST
else
    echo "Usage: $0 [update|install|install-server]"
fi
