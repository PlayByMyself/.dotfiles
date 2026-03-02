export_var_path_if_exists() {
  local var_name="$1"
  local path="$2"

  if [[ -d "$path" ]]; then
    export "$var_name=$path"
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
