#!/bin/bash

# Config
remote=false
tmux=true

# Helpers
exists() # Check if a command exists
{
    command -v "$1" >/dev/null 2>&1
}

# TMUX
if [[ "$tmux" = true ]]; then
    if !exists tmux; then
        echo "[+] Installing tmux..."
        sudo apt install tmux -y
    fi

    echo "[+] Copying TMUX configuration files..."
    cp "./tmux/tmux.conf" "$HOME/.tmux.conf"

    if [[ "$remote" = true ]]; then
        cp "./tmux/tmux.conf.local" "$HOME/.tmux.conf.local"


    echo "[+] Installing tpm..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    $HOME/.tmux/plugins/tpm/bindings/install_plugins
fi

# ZSH

# NeoVIM