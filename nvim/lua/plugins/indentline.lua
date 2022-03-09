-- Indent Blankline: https://github.com/lukas-reineke/indent-blankline.nvim

require("indent_blankline").setup({
    show_first_indent_level = false,
    show_current_context = true,
    buftype_exclude = { "nofile" },
})
