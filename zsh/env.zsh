HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt INC_APPEND_HISTORY

# Set up PATH
path+=("/home/dylan/.local/bin")
path+=("/home/dylan/.cargo/bin")
path+=("/home/dylan/.cabal/bin")
path+=("/home/dylan/.ghcup/bin")
path+=("/home/dylan/go/bin")
export PATH

export EDITOR=nvim
export VISUAL=nvim
export BROWSER=floorp

export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"
