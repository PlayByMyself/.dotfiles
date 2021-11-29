source $HOME/.antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle command-not-found
antigen bundle rustup
antigen bundle cargo
antigen bundle pyenv

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Auto suggestions
antigen bundle zsh-users/zsh-autosuggestions

# Load the theme.
antigen theme ys

# # Tell Antigen that you're done.
antigen apply
