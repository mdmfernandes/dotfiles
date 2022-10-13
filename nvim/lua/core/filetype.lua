-- File types
-- Ref.: https://gpanders.com/blog/whats-new-in-neovim-0-7/#filetypelua

vim.filetype.add({
    extension = {
        service = "systemd",
        socket = "systemd",
        target = "systemd",
        bb = "config",
    },
})