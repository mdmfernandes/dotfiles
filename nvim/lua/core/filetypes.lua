-- File types
-- Ref.: https://gpanders.com/blog/whats-new-in-neovim-0-7/#filetypelua

vim.g.did_load_filetypes = 0 -- Disable vim-based filetype plugin
vim.g.do_filetype_lua = 1 -- Enable lua-based filetype plugin

vim.filetype.add({
    extension = {
        service = "systemd",
        socket = "systemd",
        target = "systemd",
    },
})
