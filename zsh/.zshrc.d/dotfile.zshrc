function dotfile() {
    if [[ $1 = "update" ]]; then
        cd ~/.dotfiles && git pull
        cd - >/dev/null
    elif [[ $1 = "stow" ]]; then
        cd ~/.dotfiles && ls -d1 */ | xargs stow -S
        cd - >/dev/null
    else
        echo "Usage: $0 [update|stow]"
    fi
}
# auto stow
dotfile stow
