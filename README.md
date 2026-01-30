# Miguel's Dotfiles

Personal dotfiles for Linux development environment automation.

## Overview

Automated configuration script and manual setups for:

- **Zsh** - Shell with Powerlevel10k theme and plugins
- **Tmux** - Terminal multiplexer (inspired by [.tmux](https://github.com/gpakosz/.tmux))
- **Neovim** - Modern text editor with LSP and plugin management
- **Git** - Version control with GPG signing and aliases
- **Yazi** - Terminal file manager with plugins
- **WezTerm** - GPU-accelerated terminal emulator
- **Ghostty** - Modern terminal emulator
- **GDB** - Debugger with pwndbg integration
- **Language Tools** - Linters, formatters, and type checkers

## Quick Start

Automated installation:

```bash
# Clone repository
git clone https://github.com/mdmfernandes/dotfiles.git ~/src/dotfiles
cd ~/src/dotfiles

# Run automated configuration script
./autocfg.sh
```

The script will:

- Install required applications
- Configure Git with auto-rebase settings
- Install and configure Zsh with plugins
- Install and configure Tmux with tpm
- Copy Neovim configuration
- Setup linters and formatters

**Optional tools** (disabled by default):

- WezTerm (set `wezterm=true` in autocfg.sh)

## Manual Setup

If you prefer manual configuration read the _autocfg.sh_ and follow the steps.

## Fonts

For a better visual experience, use the [Fira Code Nerd
Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode) or the [JetBrains Mono Nerd
Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/JetBrainsMono).

## Documentation

- **README.md**: general information of the repository
- **AGENTS.md** - Guidelines for contributors working on the repository. Contains build/lint/test commands and code
  style guidelines

## Language Tools

The repository includes configurations for:

- **Python**: ruff, pylint, black, mypy
- **Lua**: stylua
- **Markdown**: markdownlint
- **YAML**: yamllint
- **Shell**: shellcheck

See `AGENTS.md` for usage instructions.

## Repository Structure

```text
.
├── autocfg.sh          # Automated configuration script
├── README.md           # This file
├── AGENTS.md           # Developer guidelines
├── nvim/               # Neovim configurations
├── tmux/               # Tmux configurations
├── zsh/                # Zsh configurations
├── git/                # Git configurations
├── gdb/                # GDB configurations
├── wezterm/            # WezTerm configurations
├── yazi/               # Yazi configurations
├── ghostty/            # Ghostty configurations
└── lang/               # Language-specific linting configs
```

## Customization

### Zsh Customization

Edit `zsh/custom.zsh` for personal aliases and settings.

### Neovim Plugins

Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim).

### Tmux Plugins

Plugins are managed by [tpm](https://github.com/tmux-plugins/tpm). The file `.tmux.conf.local` can be used for custom
configurations (for an example, see `tmux.conf.remote`)

## License

Personal dotfiles - use/modify as needed.
