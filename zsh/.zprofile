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

add_fpath() {
  local result=0;
  for NEW_FPATH in $@; do
    if [[ -d "$NEW_FPATH" ]] && [[ ":$FPATH:" != *":$NEW_FPATH:"* ]]; then
      export FPATH="$NEW_FPATH:$FPATH"
    else
      result=1
    fi
  done
  return result
}

# source all .zprofile files in .zprofile.d directory
setopt null_glob
ZPROFILE_DIR="$HOME/.zprofile.d"
if [[ -d $ZPROFILE_DIR ]]; then
  for PROFILE_FILE in $ZPROFILE_DIR/*.zprofile; do
    source $PROFILE_FILE
  done
fi
unsetopt null_glob