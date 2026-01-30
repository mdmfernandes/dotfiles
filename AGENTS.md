# AGENTS.md

## Overview

This is a personal dotfiles repository containing configurations for development tools. When working in this repository,
follow these guidelines to maintain consistency and quality.

## Build/Lint/Test Commands

This repository does not use traditional build systems or test suites since it contains configuration files. However,
use these commands to validate configurations:

### Linting

**Python:**

```bash
# Run ruff linter (configured in lang/python/pyproject.toml)
ruff check .

# Format Python files with ruff
ruff format .

# Check specific file
ruff check path/to/file.py
```

**Lua:**

```bash
# Format Lua files with stylua (configured in lang/lua/stylua.toml)
stylua nvim/**/*.lua
stylua wezterm/**/*.lua
stylua yazi/**/*.lua
```

**YAML:**

```bash
# Lint YAML files with yamllint (configured in lang/yaml/yamllint.yaml)
yamllint .
```

**Markdown:**

```bash
# Lint Markdown files with markdownlint (configured in lang/markdown/markdownlint.yaml)
markdownlint "*.md"
```

**Shell Scripts:**

```bash
# Check shell scripts with shellcheck
shellcheck autocfg.sh
```

## Code Style Guidelines

### General

- **Line length**: 120 characters maximum (consistent across all formatters)
- **Line endings**: Unix (LF) - configured in .editorconfig
- **Encoding**: UTF-8
- **Whitespace**: Trim trailing whitespace, insert final newline
- **Comments**: Use `--` for Lua, `#` for shell/config files

### Indentation (from .editorconfig)

- Default: 4 spaces
- C/C++/JSON/YAML/CMake: 2 spaces
- Go: tabs
- Makefiles: tabs
- Lua: 2 spaces (stylua config)
- TOML/Markdown: 4 spaces

### Lua Style (Neovim, WezTerm, Yazi)

- Use module pattern with local table exports
- Example: `local M = {}` or `local U = {}` then `return M`
- Prefer local functions over global
- Use double quotes for strings (stylua preference)
- Clear section comments above code blocks
- Use `vim.api.nvim_` functions for Neovim API calls
- Lazy-load plugins when possible

```lua
-- Good example
local M = {}

local function helper()
    -- implementation
end

function M.setup(config)
    -- setup logic
end

return M
```

### Shell Script Style (Zsh, Bash)

- Shebang: `#!/bin/env bash` or `#!/bin/env zsh`
- Use functions for reusable code
- Check command existence before using: `if exists command; then`
- Use descriptive error messages with color codes
- Add header comments describing function purpose

```bash
# Good example
function example() {
    if exists jq; then
        jq -R 'split(".") | .[0],.[1] | @base64d | fromjson' <<< "$1"
    else
        echo -e '\e[31m`jq` is not installed and is required\e[0m'
        return 1
    fi
}
```

### Configuration File Organization

- Group related configurations in directories by tool
- Use example files: `.example` suffix for custom configs
- Reference URLs for complex configurations (e.g., plugins, themes)
- Keep configuration files focused and modular

### Naming Conventions

- Directories: lowercase tool names (e.g., `nvim`, `tmux`, `zsh`)

### Error Handling

- Always check for command existence before use
- Use helper functions like `exists` in shell scripts
- Provide fallback behavior when optional tools are missing
- Clear error messages for users

### Git Configuration

- Commit title max length: 60 characters
- Commit message max length: 72 characters
- GPG signing enabled by default
- Always rebase when pulling: `branch.autoSetupRebase = always`

## Repository Structure

```text
.
├── autocfg.sh          # Automated configuration script
├── README.md           # Documentation
├── .editorconfig       # Editor configuration
├── .gitignore          # Git exclusions
├── nvim/               # Neovim configurations
├── tmux/               # Tmux configurations
├── zsh/                # Zsh configurations
├── git/                # Git configurations
├── gdb/                # GDB configurations
├── wezterm/            # WezTerm configurations
├── yazi/               # Yazi configurations
└── lang/               # Language-specific linter/formatter configs
```

## Tool-Specific Notes

### Neovim

- Uses lazy.nvim for plugin management
- LSP configured in `nvim/lua/lsp/`
- Plugins in `nvim/lua/plugins/`
- Format on save enabled with conform.nvim
- Linting on save enable with nvim-lint

### Zsh

- Powerlevel10k theme: `p10k.zsh`
- Aliases in `aliases.zsh`
- Functions in `functions.zsh`
- Custom configs in `custom.zsh`
- ZDOTDIR set to `$HOME/.config/zsh`

### Autocfg Script

- Configurable via flags at top of script
- Supports remote configuration flag `-r` or `--remote`
- Installs dependencies when missing
- Copies configurations to appropriate locations

## Adding New Configurations

1. Create directory for tool in root
2. Add configuration files following naming conventions
3. Add section to `autocfg.sh` with installation checks
4. Create/update language-specific linting config if needed
5. Update README.md if tool is user-facing

## Testing Changes

Since this is a dotfiles repository:

1. **Test in isolation**: Create temporary directory to test changes
2. **Lint**: Run appropriate linters for changed files
3. **Validate**: Run tool-specific validation commands
4. **Document**: Update README.md if adding/removing tools
5. **Script test**: Test `autocfg.sh` in safe environment first

## Common Patterns

### Checking for Tool Installation

```bash
if ! exists toolname; then
    echo "  [!] Tool not found. Please install..."
fi
```

### Copying Configuration Files

```bash
mkdir -p "$HOME/.config/tool"
cp "./tool/config" "$HOME/.config/tool/"
```

## References

- [Ruff documentation](https://docs.astral.sh/ruff/)
- [Stylua documentation](https://github.com/JohnnyMorganz/StyLua)
- [Yamllint documentation](https://yamllint.readthedocs.io/)
- [Neovim Lua guide](https://neovim.io/doc/user/lua.html)
