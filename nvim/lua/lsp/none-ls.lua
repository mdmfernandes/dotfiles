-- none-ls: https://github.com/nvimtools/none-ls.nvim
local none_ls_status_ok, none_ls = pcall(require, "null-ls")
if not none_ls_status_ok then
    return
end

local ca = none_ls.builtins.code_actions
local fmt = none_ls.builtins.formatting
local diag = none_ls.builtins.diagnostics

local u = require("lsp.utils")

local sources = {
    -- Code actions
    ca.gitsigns,

    -- Formatting
    fmt.black,        -- Python
    fmt.clang_format, -- C/C++
    fmt.markdownlint, -- Markdown
    fmt.taplo,        -- TOML
    fmt.trim_whitespace.with({
        disabled_filetypes = { "go", "gomod", "json", "lua" },
    }),
    fmt.shfmt, -- Bash
    -- fmt.stylua.with({ -- Lua
    --     extra_args = { "--config-path", vim.fn.expand("~/.config/stylua.toml") },
    -- }),

    -- Diagnostics
    diag.misspell,
    diag.trail_space.with({
        diagnostics_format = "#{s}: #{m}",
        disabled_filetypes = { "gitcommit", "NeogitCommitMessage" },
    }),
    diag.pylint,             -- Python
    diag.flake8,             -- Python
    diag.mypy,               -- Python
    diag.yamllint,           -- YAML
    diag.hadolint,           -- Docker
    diag.zsh,                -- zsh
    diag.markdownlint.with({ -- Markdown
        extra_args = { "--config", vim.fn.expand("~/.config/markdownlint.yaml") },
    }),
}

none_ls.setup({
    -- debug = true,
    sources = sources,
    -- <source_name>[<code>]: <message>
    diagnostics_format = "#{s}[#{c}]: #{m}",
    on_attach = function(client, bufnr)
        u.mappings(client, bufnr)
        u.format_document(client, bufnr)
    end,
})
