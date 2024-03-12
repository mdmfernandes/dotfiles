-- none-ls configuration: https://github.com/nvimtools/none-ls.nvim
local NLS = {}

local nls_status_ok, nls = pcall(require, "null-ls")
if not nls_status_ok then
    return
end

-- local ca = nls.builtins.code_actions
local fmt = nls.builtins.formatting
local diag = nls.builtins.diagnostics

local sources = {
    -- Formatting
    fmt.clang_format, -- C/C++
    fmt.prettier,     -- JavaScript, TypeScript, CSS, JSON, YAML, Markdown
    fmt.shfmt,        -- Bash

    -- Diagnostics
    diag.hadolint,           -- Docker
    diag.markdownlint.with({ -- Markdown
        extra_args = { "--config", vim.fn.expand("~/.config/markdownlint.yaml") },
    }),
    diag.yamllint, -- YAML
    diag.zsh,      -- zsh
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
