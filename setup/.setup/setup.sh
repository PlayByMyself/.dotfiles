#!/bin/sh

echo $(dirname $(readlink -f $0))

PACKAGE_LIST=(
    zsh
    stow
    git
    python
)

init_package_manager() {
    # FreeBSD
    if type -p pkg >/dev/null; then
        PACKAGE_COMMAND="pkg"
        PACKAGE_INSTALL="install -y"
        PACKAGE_UPDATE="update"
    # Ubuntu
    elif type -p apt-get >/dev/null; then
        PACKAGE_COMMAND="apt-get"
        PACKAGE_INSTALL="install -y"
        PACKAGE_UPDATE="update"
    # CentOS
    elif type -p yum >/dev/null; then
        PACKAGE_COMMAND="yum"
        PACKAGE_INSTALL="install -y"
        PACKAGE_UPDATE="makecache"
    # Arch
    elif type -p pacman >/dev/null; then
        PACKAGE_COMMAND="pacman"
        PACKAGE_INSTALL="-S"
        PACKAGE_UPDATE="-Syy"
    # Openwrt
    elif type -p opkg >/dev/null; then
        PACKAGE_COMMAND="opkg"
        PACKAGE_INSTALL="install"
        PACKAGE_UPDATE="update"
    # Rest
    else
        echo "Unsupported package manager"
        exit 1
    fi
}

package_manager_update() {
    $PACKAGE_COMMAND $PACKAGE_UPDATE
}

package_manager_install() {
    if type -p $1 >/dev/null; then
        echo "$1 is already installed"
        return
    else
        echo "Installing package $1"
        $PACKAGE_COMMAND $PACKAGE_INSTALL $1
    fi
}

init_package_manager
if [ "$1" = "update" ]; then
    package_manager_update
elif [ "$1" = "install" ]; then
    for PACKAGE in ${PACKAGE_LIST[@]}; do
        package_manager_install $PACKAGE
    done
else
    echo "Usage: $0 [update|install]"
fi
