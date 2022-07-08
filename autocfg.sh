#!/bin/bash
echo "################################################################"
echo "# This script configures 'TMUX', 'ZSH', and 'NeoVIM' for Linux #"
echo "################################################################"
echo ""
echo "More info available at https://github.com/mdmfernandes/dotfiles"
echo ""
read -n 1 -s -r -p "Press any key to continue..."

# Read input flags
while test $# -gt 0; do
	case "$1" in
	-r | --remote)
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
lang=true

# Helpers
exists() { # Check if a command exists
	command -v "$1" >/dev/null 2>&1
}

# Applications
if [[ "$apps" = true ]]; then
	echo "[+] Installing applications [git, jq, colordiff, xclip, fzf, ripgrep, bat, tree, fd pip3]..."
	sudo apt install --yes --quiet git jq colordiff xclip fzf ripgrep tree fd python3-pip
	sudo apt install --yes --quiet bat
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
		chsh -s $(which zsh)
	fi

	echo "  [+] Copying ZSH configuration files..."
	mkdir -p $HOME/.config/zsh
	echo "ZDOTDIR=$HOME/.config/zsh" >$HOME/.zshenv && . $HOME/.zshenv
	cp "./zsh/zshrc" "$ZDOTDIR/.zshrc"
	cp "./zsh/aliases.zsh" "$ZDOTDIR/.aliases.zsh"
	cp "./zsh/functions.zsh" "$ZDOTDIR/.functions.zsh"
	cp "./zsh/custom.zsh" "$ZDOTDIR/.custom.zsh"
	cp "./zsh/p10k.zsh" "$ZDOTDIR/.p10k.zsh"
	source $ZDOTDIR/.zshrc 2>/dev/null

	echo "  [+] Installing custom plugins..."
	ZSH_SHARE="$HOME/.local/share/zsh"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_SHARE}/themes/powerlevel10k
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_SHARE}/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_SHARE}/plugins/zsh-autosuggestions
	curl curl -sS https://webinstall.dev/zoxide | bash
fi

# NeoVim
if [[ "$neovim" = true ]]; then
	echo ""
	echo "[+] Configuring NeoVim..."

	if ! exists nvim; then
		echo "  [+] Installing NeoVim..."
		sudo apt install neovim --yes --quiet
	fi

	echo "  [+] Copying NeoVIM configuration files..."
	cp -r ./nvim $HOME/.config
fi

if [[ "$lang" = true ]]; then
	echo ""
	echo "[+] Configuring linters, formatters, and type checkers..."
	pip3 install pylint flake8 black mypy
	cp -r ./lang/python/ $HOME/.config
	cp ./lang/stylua.toml $HOME/.config
	cp ./lang/markdownlint.yaml $HOME/.config
