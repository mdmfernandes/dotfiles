-- none-ls configuration: https://github.com/nvimtools/none-ls.nvim
local NLS = {}

local nls_status_ok, nls = pcall(require, "null-ls")
if not nls_status_ok then
    return
end

local ca = nls.builtins.code_actions
local fmt = nls.builtins.formatting
local diag = nls.builtins.diagnostics

local sources = {
    -- Code actions
    ca.gitsigns,
    ca.shellcheck,

    -- Formatting
    fmt.black,        -- Python
    fmt.clang_format, -- C/C++
    fmt.markdownlint, -- Markdown
    fmt.taplo,        -- TOML
    fmt.trim_whitespace.with({
        disabled_filetypes = { "go", "gomod", "json", "lua" },
    }),
    fmt.shfmt, -- Bash

    -- Diagnostics
    -- diag.misspell, -- Using vim spell
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

-- Setup none-ls
function NLS.setup(opts)
    nls.setup({
        debug = false,
        -- <source_name>[<code>]: <message>
        diagnostics_format = "#{s}[#{c}]: #{m}",
        on_attach = opts.on_attach,
        sources = sources,
    })
end

return NLS
