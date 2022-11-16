add_path() {
  local result=0;
  for NEW_PATH in $@; do
    if [[ -d "$NEW_PATH" ]] && [[ ":$PATH:" != *":$NEW_PATH:"* ]]; then
      export PATH="$NEW_PATH:$PATH"
    else
      result=1
    fi
  done
  return result
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
