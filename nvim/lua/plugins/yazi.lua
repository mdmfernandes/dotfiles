-- yazi.nvim: https://github.com/mikavilpas/yazi.nvim
return {
    ---@type LazySpec
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<Leader>,",
                "<Cmd>Yazi<CR>",
                desc = "Open yazi at the current file location",
            },
            {
                "<Leader>.",
                "<Cmd>Yazi cwd<CR>",
                desc = "Open yazi in working directory",
            },
            {
                "<C-.>",
                "<Cmd>Yazi toggle<CR>",
                desc = "Resume the last yazi session",
            },
        },
        ---@type YaziConfig
        opts = {
            open_for_directories = true,
            keymaps = {
                open_file_in_horizontal_split = "<c-h>",
            },
        },
    },
}
