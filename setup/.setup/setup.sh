#!/bin/bash

BASE_PACKAGE_LIST=(
    zsh
    stow
    git
    python3
    wget
    curl
    screen
    vim
    sudo
    tmux
    gpg
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
        MANAGER_COMMAND="sudo pkg"
        MANAGER_INSTALL="install -y"
        MANAGER_UPDATE="update"
        MANAGER_PACKAGE_LIST=()
    # Ubuntu
    elif type -p apt-get >/dev/null; then
        MANAGER_COMMAND="sudo apt-get"
        MANAGER_INSTALL="install -y"
        MANAGER_UPDATE="update"
        MANAGER_PACKAGE_LIST=(
            build-essential
            libssl-dev
        )
    # CentOS
    elif type -p yum >/dev/null; then
        MANAGER_COMMAND="sudo yum"
        MANAGER_INSTALL="install -y"
        MANAGER_UPDATE="makecache"
        MANAGER_PACKAGE_LIST=(
            gcc
            openssl-devel
        )
    # Arch
    elif type -p pacman >/dev/null; then
        MANAGER_COMMAND="sudo pacman"
        MANAGER_INSTALL="-S --noconfirm --needed"
        MANAGER_UPDATE="-Sy"
        MANAGER_PACKAGE_LIST=(
            base-devel
        )
    # Openwrt
    elif type -p opkg >/dev/null; then
        MANAGER_COMMAND="sudo opkg"
        MANAGER_INSTALL="install"
        MANAGER_UPDATE="update"
        MANAGER_PACKAGE_LIST=()
    # MacOS
    elif type -p brew >/dev/null; then
        MANAGER_COMMAND="brew"
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

stow_dotfiles() {
    cd ~/.dotfiles && ls -d1 */ | xargs stow -S
    cd - >/dev/null
}

exit_if_root() {
    if [[ $EUID -eq 0 ]]; then
        echo "This script should not be run as root"
        exit 1
    fi
}

exit_if_root
init_package_manager
init_sheldon
PROFILE=$1
if [[ $PROFILE = "dev" ]]; then
    ALL_PACKAGE_LIST=(${BASE_PACKAGE_LIST[@]} ${DEVELOP_PACKAGE_LIST[@]} ${MANAGER_PACKAGE_LIST[@]})
elif [[ $PROFILE = "server" ]]; then
    ALL_PACKAGE_LIST=(${BASE_PACKAGE_LIST[@]} ${SERVER_PACKAGE_LIST[@]} ${MANAGER_PACKAGE_LIST[@]})
else
    echo "Usage: $0 [dev|server]"
    exit 1
fi

$MANAGER_COMMAND $MANAGER_UPDATE
echo "All package list: ${ALL_PACKAGE_LIST[@]}"
$MANAGER_COMMAND $MANAGER_INSTALL ${ALL_PACKAGE_LIST[@]}
for installer in ${EXTRA_INSTALLER_LIST[@]}; do
    bash $(dirname $0)/installer/$installer $PROFILE
done
stow_dotfiles
