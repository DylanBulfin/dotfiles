HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt INC_APPEND_HISTORY

export EDITOR=nvim
export VISUAL=nvim
export BROWSER=firefox

export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

path+=('/opt/homebrew/bin')
path+=('/home/dylan/.local/bin')
path+=('/home/dylan/.cargo/bin')
path+=('/Users/dylan/.cargo/bin')

export PATH
