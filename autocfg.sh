#!/bin/bash
echo "###################################################################"
echo "# This script configures dotfiles for Linux                       #"
echo "# Configures: ZSH, Tmux, Neovim, Git, WezTerm, Yazi, GDB, Ghostty #"
echo "###################################################################"
echo ""
echo "More info available at https://github.com/mdmfernandes/dotfiles"
echo ""
read -n 1 -s -r -p "Press any key to continue..."
echo ""
echo ""

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
ghostty=true
wezterm=false
yazi=true
gdb=true
lang=false

# Helpers
exists() { # Check if a command exists
	command -v "$1" >/dev/null 2>&1
}

# Update DB
sudo apt-get update

# Applications
if [[ "$apps" = true ]]; then
	echo "[+] Installing applications [git, jq, colordiff, xclip, fzf, ripgrep, bat, tree, fd, pip3, zoxide]..."
	sudo apt-get install --yes --quiet --no-install-recommends git jq colordiff xclip fzf ripgrep tree fd-find python3-pip curl
	sudo apt-get install --yes --quiet --no-install-recommends bat
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
		sudo apt-get install --yes --quiet --no-install-recommends tmux
	fi

	echo "  [+] Copying TMUX configuration files..."
	cp "./tmux/tmux.conf" "$HOME/.tmux.conf"

	if [[ "$remote" = true ]]; then
		cp "./tmux/tmux.conf.remote" "$HOME/.tmux.conf.local"
	fi

	echo "  [+] Installing tpm..."
	git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
	tmux source "$HOME/.tmux.conf"
	"$HOME/.tmux/plugins/tpm/bindings/install_plugins"
fi

# ZSH
if [[ "$zsh" = true ]]; then
	echo ""
	echo "[+] Configuring ZSH..."

	if ! exists zsh; then
		echo "  [+] Installing ZSH..."
		sudo apt-get install --yes --quiet --no-install-recommends zsh
		chsh -s "$(which zsh)"
	fi

	echo "  [+] Copying ZSH configuration files..."
	mkdir -p "$HOME/.config/zsh"
	mkdir -p "$HOME/.local/share/zsh/plugins"
	mkdir -p "$HOME/.local/share/zsh/completions"
	mkdir -p "$HOME/.local/share/zsh/themes"

    # shellcheck source=/dev/null
	echo "ZDOTDIR=$HOME/.config/zsh" >"$HOME/.zshenv" && . "$HOME/.zshenv"
	cp "./zsh/zshrc" "$ZDOTDIR/.zshrc"
	cp "./zsh/aliases.zsh" "$ZDOTDIR/aliases.zsh"
	cp "./zsh/functions.zsh" "$ZDOTDIR/functions.zsh"
	cp "./zsh/custom.zsh" "$ZDOTDIR/custom.zsh"
	cp "./zsh/p10k.zsh" "$ZDOTDIR/p10k.zsh"
    # shellcheck source=/dev/null
	source "$ZDOTDIR/.zshrc" 2>/dev/null

	echo "  [+] Installing custom plugins..."
	ZSH_SHARE="$HOME/.local/share/zsh"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_SHARE}/themes/powerlevel10k"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_SHARE}/plugins/zsh-syntax-highlighting"
	git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_SHARE}/plugins/zsh-autosuggestions"
	git clone https://github.com/zsh-users/zsh-completions.git "${ZSH_SHARE}/plugins/zsh-completions"
	git clone https://github.com/zsh-users/zsh-history-substring-search.git "${ZSH_SHARE}/plugins/zsh-history-substring-search"
	curl -sS https://webinstall.dev/zoxide | bash
fi

# NeoVim
if [[ "$neovim" = true ]]; then
	echo ""
	echo "[+] Configuring Neovim..."

	if ! exists nvim; then
		echo "  [+] Installing NeoVim..."
		sudo apt-get install --yes --quiet --no-install-recommends neovim
	fi

	echo "  [+] Copying neovim configuration files..."
	cp -r ./nvim "$HOME/.config"
fi

# WezTerm
if [[ "$wezterm" = true ]]; then
	echo ""
	echo "[+] Configuring WezTerm..."

	if ! exists wezterm; then
		echo "  [!] WezTerm not found. Please install from https://wezfurlong.org/wezterm"
	else
		echo "  [+] Copying WezTerm configuration files..."
		mkdir -p "$HOME/.config/wezterm"
		cp "./wezterm/wezterm.lua" "$HOME/.config/wezterm/"
		cp "./wezterm/wezterm_local.lua" "$HOME/.config/wezterm/"
	fi
fi

# Yazi
if [[ "$yazi" = true ]]; then
	echo ""
	echo "[+] Configuring Yazi..."

	if ! exists yazi; then
		echo "  [!] Yazi not found. Please install from https://yazi-rs.github.io/"
		echo "  [!] Or with cargo: cargo install yazi-build"
	else
		echo "  [+] Copying Yazi configuration files..."
		mkdir -p "$HOME/.config/yazi"
        cp -r "./yazi" "$HOME/.config/yazi"
	fi
fi

# Ghostty
if [[ "$ghostty" = true ]]; then
	echo ""
	echo "[+] Configuring Ghostty..."

	if ! exists ghostty; then
		echo "  [!] Ghostty not found. Please install from https://github.com/ghostty-org/ghostty"
	else
		echo "  [+] Copying Ghostty configuration files..."
		mkdir -p "$HOME/.config/ghostty"
		cp "./ghostty/config" "$HOME/.config/ghostty/"
	fi
fi

# GDB
if [[ "$gdb" = true ]]; then
	echo ""
	echo "[+] Configuring GDB..."

	if ! exists gdb; then
		echo "  [+] Installing GDB..."
		sudo apt-get install gdb --yes --quiet
	fi

	echo "  [+] Copying GDB configuration files..."
	mkdir -p "$HOME/.config/gdb"
	mkdir "$HOME/.local/src"
	cp "./gdb/gdbinit" "$HOME/.gdbinit"
    cp "./gdb/pwndbgtmux.py" "$HOME/.local/src/pwndbgtmux.py"

	# Check for pwndbg
	if [[ ! -d "$HOME/src/pwndbg" ]]; then
		echo ""
		echo "  [!] pwndbg not found!"
		echo "  [!] Install pwndbg for enhanced GDB debugging:"
		echo "  [!]   git clone https://github.com/pwndbg/pwndbg.git ~/.local/src/pwndbg"
		echo "  [!]   cd ~/.local/src/pwndbg && ./setup.sh"
	fi
fi

# Language tools
if [[ "$lang" = true ]]; then
	echo ""
	echo "[+] Configuring linters, formatters, and type checkers..."
	pip3 install pylint flake8 black mypy markdownlint-cli

	echo "  [+] Copying language configuration files..."
	cp -r ./lang/python/ "$HOME/.config"
	cp ./lang/lua/stylua.toml "$HOME/.config"
	cp ./lang/markdown/markdownlint.yaml "$HOME/.config"
	cp ./lang/yaml/yamllint.yaml "$HOME/.config"
	cp ./lang/.editorconfig "$HOME/.config/"
fi

echo ""
echo "[+] Configuration complete!"
echo "[+] Please restart your shell to apply changes"
