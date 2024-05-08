if status is-interactive
    alias ls="ls --color=auto"
    abbr -a -g ll    ls -la
    abbr -a -g ref   source /home/dylan/.config/fish/config.fish
    abbr -a -g e     exit

    fish_add_path "/home/dylan/go/bin"
    fish_add_path "/home/dylan/bin"
    fish_add_path "/home/dylan/.cargo/bin"
    fish_add_path "/home/dylan/.cabal/bin"
    fish_add_path "/home/dylan/.ghcup/bin"
    fish_add_path "/home/dylan/.local/bin"

    set fish_cursor_default block
    set fish_cursor_insert line
    fish_vi_key_bindings

    set -U fish_greeting ""
    set -Ux EDITOR nvim
    set -Ux VISUAL nvim
    set -Ux BROWSER floorp

    bind --mode insert \cF forward-char
    bind --mode insert \e\cz _fzf_z
    bind --mode default \e\cz _fzf_z
    bind --mode visual \e\cz _fzf_z

    #Should stay at end
    zoxide init fish | source
end
