-- eyeliner: https://github.com/jinh0/eyeliner.nvim
-- Highlight code search with find (f/F) and 'till (t/T)
vim.pack.add({
    { src = "https://github.com/jinh0/eyeliner.nvim", name = "eyeliner" },
})

require("eyeliner").setup({
    highlight_on_key = true,
})

vim.api.nvim_set_hl(0, "EyelinerPrimary", { fg = "#ffffff", bold = true })
vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = "#f5bde6", bold = true })
