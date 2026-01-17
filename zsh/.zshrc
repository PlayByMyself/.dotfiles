# source all .zshrc files in .zshrc.d directory
setopt null_glob
ZSH_RC_DIR="$HOME/.zshrc.d"
if [[ -d $ZSH_RC_DIR ]]; then
  for RC_FILE in $ZSH_RC_DIR/*.zshrc; do
    source $RC_FILE
  done
fi
unsetopt null_glob

# bun completions
[ -s "/Users/yejun/.bun/_bun" ] && source "/Users/yejun/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
