#!/bin/sh

export PACKAGE_LIST=(
    zsh  # shell interpreter
    stow # dotfiles management
    git  # version control
)

init_package_manager() {
    # FreeBSD
    if type -p pkg >/dev/null; then
        export PACKAGE_COMMAND="pkg"
        export PACKAGE_INSTALL="install -y"
        export PACKAGE_UPDATE="update"
    # Ubuntu
    elif type -p apt-get >/dev/null; then
        export PACKAGE_COMMAND="apt-get"
        export PACKAGE_INSTALL="install -y"
        export PACKAGE_UPDATE="update"
    # CentOS
    elif type -p yum >/dev/null; then
        export PACKAGE_COMMAND="yum"
        export PACKAGE_INSTALL="install -y"
        export PACKAGE_UPDATE="makecache"
    # Arch
    elif type -p pacman >/dev/null; then
        export PACKAGE_COMMAND="pacman"
        export PACKAGE_INSTALL="-S"
        export PACKAGE_UPDATE="-Syy"
    # Openwrt
    elif type -p opkg >/dev/null; then
        export PACKAGE_COMMAND="opkg"
        export PACKAGE_INSTALL="install"
        export PACKAGE_UPDATE="update"
    # Rest
    else
        echo "Unsupported package manager"
        exit 1
    fi
}

update_package_manager() {
    $PACKAGE_COMMAND $PACKAGE_UPDATE
}

install_package() {
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
    update_package_manager
elif [ "$1" = "install" ]; then
    for PACKAGE in ${PACKAGE_LIST[@]}; do
        install_package $PACKAGE
    done
else
    echo "Usage: $0 [update|install]"
fi
