#!/bin/bash

sudo -v

if [[ -e "/usr/local/bin/nvim" ]]; then
    if ! sudo mv /usr/local/bin/nvim /usr/local/bin/_nvim; then
        echo "Error deregistering neovim nightly"
        exit 1
    fi
    if ! sudo pacman -S --noconfirm neovim; then
        echo "Failed to install neovim stable"
        exit 1
    fi
    rm /home/dylan/.config/nvim
    if ! ln -s /home/dylan/.config/nvim_stable /home/dylan/.config/nvim; then
        echo "Failed to link neovim stable config"
        exit 1
    fi
    rm -rf /home/dylan/.cache/nvim
    rm -rf /home/dylan/.local/share/nvim
    rm -rf /home/dylan/.local/state/nvim
else
    if ! sudo mv /usr/local/bin/_nvim /usr/local/bin/nvim; then
        echo "Error registering neovim nightly"
        exit 1
    fi
    if ! sudo pacman -R --noconfirm neovim; then
        echo "Failed to remove neovim stable"
        exit 1
    fi
    rm /home/dylan/.config/nvim
    if ! ln -s /home/dylan/.config/nvim_nightly /home/dylan/.config/nvim; then
        echo "Failed to link neovim nightly config"
        exit 1
    fi
    rm -rf /home/dylan/.cache/nvim
    rm -rf /home/dylan/.local/share/nvim
    rm -rf /home/dylan/.local/state/nvim
fi
