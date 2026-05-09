-- yazi.nvim: https://github.com/mikavilpas/yazi.nvim
vim.pack.add({
    { src = "https://github.com/mikavilpas/yazi.nvim", name = "yazi" },
    { src = "https://github.com/nvim-lua/plenary.nvim" } })

require("yazi").setup({
    opts = {
        open_for_directories = true,
        keymaps = {
            open_file_in_horizontal_split = "<c-h>",
        },
    },
})

-- Key Mappings
vim.keymap.set("n", "<Leader>,", "<Cmd>Yazi<CR>", { desc = "Open Yazi at the current file location" })
vim.keymap.set("n", "<Leader>.", "<Cmd>Yazi cwd<CR>", { desc = "Open Yazi in working directory" })
