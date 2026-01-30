-- Diagnostics
local d = require("defaults")

-- Symbols in the sign column (gutter)
local signs = require("icons").diagnostics

local sign_icons = {
    [vim.diagnostic.severity.ERROR] = signs.Error,
    [vim.diagnostic.severity.WARN] = signs.Warn,
    [vim.diagnostic.severity.INFO] = signs.Info,
    [vim.diagnostic.severity.HINT] = signs.Hint,
}

-- Config
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
-- https://neovim.io/doc/user/api.html#nvim_open_win()
vim.diagnostic.config({
    virtual_text = true,
    signs = { text = sign_icons }, -- show symbols in the gutter
    underline = true, -- use underline text for diagnostics (default)
    update_in_insert = false, -- update diagnostics during insert mode
    severity_sort = true, -- sort diagnostics by severity (show severe first)
    float = d.border_opts,
})
