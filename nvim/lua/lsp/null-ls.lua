-- null-ls: https://github.com/jose-elias-alvarez/null-ls.nvim
local null_ls = require("null-ls")
local nb = null_ls.builtins

local sources = {
  -- code actions
  nb.code_actions.gitsigns,
  -- formatting
  nb.formatting.trim_whitespace,
  nb.formatting.black, -- Python
  nb.formatting.stylua.with({ -- Lua
    extra_args = { "--config-path", vim.fn.expand("~/.config/stylua.toml") },
  }),
  nb.formatting.shfmt, -- Bash
  nb.formatting.prettier, -- Multiple languages
  -- diagnostics
  nb.diagnostics.write_good,
  nb.diagnostics.trail_space,
  nb.diagnostics.pylint, -- Python
  nb.diagnostics.flake8, -- Python
  nb.diagnostics.mypy, -- Python
  nb.diagnostics.yamllint, -- YAML
  nb.diagnostics.hadolint, -- Docker
  nb.diagnostics.zsh, -- zsh
  nb.diagnostics.gitlint, -- Git
  nb.diagnostics.markdownlint.with({ -- Markdown
    extra_args = { "--config", vim.fn.expand("~/.config/.markdownlint.yaml") },
  }),
}

local M = {}

M.setup = function(on_attach, capabilities)
  null_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    sources = sources,
    -- <source_name>[<code>]: <message>
    diagnostics_format = "#{s}[#{c}]: #{m}",
  })
end

return M
