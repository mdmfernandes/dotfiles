-- Diagnostics
local d = require("defaults")

-- Config
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
-- https://neovim.io/doc/user/api.html#nvim_open_win()
vim.diagnostic.config({ virtual_text = true, float = d.border_opts })

-- Symbols in the gutter
local signs = { Error = "✗", Warn = "", Hint = "", Info = "" }

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
