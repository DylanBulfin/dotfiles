# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zsh/env.zsh
source ~/.zsh/aliases.zsh

# fpath+=~/.zsh/completions

# all Tab widgets

setopt interactivecomments transientrprompt

function zvm_after_init() {
  # Set up fzf key bindings and fuzzy completion
  eval "$(fzf --zsh)"

  # Needs to be sourced here to avoid bindings being overwritten
  source ~/.zsh/keymap.zsh
  
  zstyle ':autocomplete:*complete*:*' insert-unambiguous yes

  # all history widgets
  zstyle ':autocomplete:*history*:*' insert-unambiguous yes

  # ^S
  zstyle ':autocomplete:menu-search:*' insert-unambiguous yes

  zstyle ':completion:*:*' matcher-list 'm:{[:lower:]-}={[:upper:]_}' '+r:|[.]=**'
}

source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
 
source ~/.zsh/plugins/auto-ls/auto-ls.zsh
source ~/.zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

source ~/.zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/.zsh/plugins/catppuccin/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(zoxide init zsh)"

source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
