#!/bin/bash

echo "######################################################"
echo "# This script configures 'TMUX', 'ZSH', and 'NeoVIM' #"
echo "######################################################"
echo ""
echo "More info available at https://github.com/mdmfernandes/dotfiles"
echo ""
read -n 1 -s -r -p "Press any key to continue..."

# Read input flags
while test $# -gt 0; do
    case "$1" in
        -r|--remote)
            remote=true
            shift
            ;;
        *)
            break
            ;;
    esac
done

# Config
apps=true
tmux=true
zsh=true
neovim=true

# Helpers
exists() # Check if a command exists
{
    command -v "$1" >/dev/null 2>&1
}

# Applications
if [[ "$apps" = true ]]; then
    echo "[+] Installing applications [git, jq, colordiff, xclip, fzf, bat, tree]..."
    sudo apt install --yes --quiet git jq colordiff xclip fzf bat tree
    # Configure git
    git config --global branch.autoSetupRebase always
    git config --global core.pager "less -F -X"
fi

# TMUX
if [[ "$tmux" = true ]]; then
    echo ""
    echo "[+] Configuring TMUX..."

    if ! exists tmux; then
        echo "  [+] Installing TMUX..."
        sudo apt install tmux --yes --quiet
    fi

    echo "  [+] Copying TMUX configuration files..."
    cp "./tmux/tmux.conf" "$HOME/.tmux.conf"

    if [[ "$remote" = true ]]; then
        cp "./tmux/tmux.conf.remote" "$HOME/.tmux.conf.local"
    fi

    echo "  [+] Installing tpm..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    tmux source "$HOME/.tmux.conf"
    $HOME/.tmux/plugins/tpm/bindings/install_plugins
fi

# ZSH
if [[ "$zsh" = true ]]; then
    echo ""
    echo "[+] Configuring ZSH..."

    if ! exists zsh; then
        echo "  [+] Installing ZSH..."
        sudo apt install zsh --yes --quiet
    fi

    echo "  [+] Copying ZSH configuration files..."
    mkdir -p $HOME/.config/zsh
    echo "ZDOTDIR=$HOME/.config/zsh" > $HOME/.zshenv && . $HOME/.zshenv
    cp "./zsh/zshrc" "$HOME/.config/zsh/.zshrc"
    cp "./zsh/custom.zsh" "$HOME/.config/zsh/.custom.zsh"
    cp "./zsh/p10k.zsh" "$HOME/.config/zsh/.p10k.zsh"
    source $HOME/.config/zsh/.zshrc 2>/dev/null

    echo "  [+] Installing oh-my-zsh..."
    export RUNZSH="no"
    export KEEP_ZSHRC="yes"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    source $HOME/.config/zsh/.zshrc 2>/dev/null
    cp "./zsh/aliases.zsh" "$ZSH_CUSTOM/aliases.zsh"
    rm -f $HOME/.zshrc

    echo "  [+] Installing custom plugins..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
fi

# NeoVIM
if [[ "$neovim" = true ]]; then
    echo ""
    echo "[+] Configuring NeoVIM..."

    if ! exists zsh; then
        echo "  [+] Installing NeoVIM..."
        sudo apt install neovim --yes --quiet
    fi

    echo "  [+] Copying ZSH configuration files..."
    mkdir -p "$HOME/.config/nvim"
    cp "./nvim/init.vim" "$HOME/.config/nvim/init.vim"

    echo "  [+] Installing vim-plug..."
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    nvim +PlugInstall

    echo "  [+] Installing PIP..."
    sudo apt install python3-pip

    echo "  [+] Installing and Configuring linters and fixers..."
    pip3 install pylint flake8 yapf
    cp -r ./nvim/ftplugin $HOME/.config/nvim/ftplugin
    cp -r ./nvim/configs/* $HOME/.config
fi
