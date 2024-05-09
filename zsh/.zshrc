# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

alias e='exit'
alias ls='ls --color=auto'
alias ll='ls -la'
alias ref='source ~/.zshrc'

# Set up PATH
path=("/home/dylan/.local/bin")
path=("/home/dylan/.cargo/bin")
path=("/home/dylan/.cabal/bin")
path=("/home/dylan/.ghcup/bin")
path=("/home/dylan/go/bin")
export PATH

export EDITOR=nvim
export VISUAL=nvim
export BROWSER=floorp

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.zsh/auto-ls/auto-ls.zsh
source ~/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/.zsh/catppuccin/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(zoxide init zsh)"
