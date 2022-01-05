if type -p screen >/dev/null 2>&1; then
    export SCREENDIR=$HOME/.screen
    [[ -d $SCREENDIR ]] || mkdir -p -m 700 $SCREENDIR
fi
