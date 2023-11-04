-- Diagnostics
local d = require("defaults")

-- Symbols in the sign column (gutter)
local signs = require("icons").diagnostics

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Config
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
-- https://neovim.io/doc/user/api.html#nvim_open_win()
vim.diagnostic.config({
    virtual_text = true,
    signs = true,             -- show symbols in the gutter (default)
    underline = true,         -- use underline text for diagnostics (default)
    update_in_insert = false, -- update diagnostics during insert mode
    severity_sort = true,     -- sort diagnostics by severity (show more severe first)
    float = d.border_opts
})
