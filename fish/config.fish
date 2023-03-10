if status is-interactive
    alias ls="ls --color=auto"
    abbr -a -g ll    ls -la
    abbr -a -g stmon /bin/bash /home/dylan/bin/startup
    abbr -a -g ref   source /home/dylan/.config/fish/config.fish
    abbr -a -g e     exit

    fish_add_path "/home/dylan/go/bin"
    fish_add_path "/home/dylan/bin"
    fish_add_path "/home/dylan/.cargo/bin"
    fish_add_path "/home/dylan/.cabal/bin"
    fish_add_path "/home/dylan/.ghcup/bin"

    set fish_cursor_default block
    set fish_cursor_insert line
    fish_vi_key_bindings
end
