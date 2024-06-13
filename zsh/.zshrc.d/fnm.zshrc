if type -p fnm >/dev/null 2>&1; then
    eval "$(fnm env --use-on-cd)"
fi
