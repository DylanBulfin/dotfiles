bindkey '^I' menu-complete
bindkey '^F' vi-forward-char
bindkey '^H' backward-kill-word
bindkey '^K' kill-line

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M menuselect '^[' undo
bindkey '^[[Z' reverse-menu-complete

bindkey '^[[1;5D' vi-backward-word
bindkey '^[[1;5C' vi-forward-word
bindkey -M vicmd '^[[1;5D' vi-backward-word
bindkey -M vicmd '^[[1;5C' vi-forward-word
