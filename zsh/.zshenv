add_path() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
    return 0
  else
    return 1
  fi
}

# source all .zshenv files in .zshenv.d directory
setopt null_glob
ZSH_ENV_DIR="$HOME/.zshenv.d"
if [[ -d $ZSH_ENV_DIR ]]; then
  for ENV_FILE in $ZSH_ENV_DIR/*.zshenv; do
    source $ENV_FILE
  done
fi
unsetopt null_glob
