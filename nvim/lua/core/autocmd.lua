-- Autocommands
local api = vim.api

local my_au = api.nvim_create_augroup("MyGroup", { clear = true })

-- Show current cursor diagnostics
api.nvim_create_autocmd("CursorHold", {
    group = my_au,
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false, scope = "cursor" })
    end,
})

-- Highlight the region on yank
api.nvim_create_autocmd("TextYankPost", {
    group = my_au,
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 350 })
    end,
})

-- Set spell for certain file types
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = my_au,
    pattern = { "NeogitCommitMessage", "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.spell = true
    end,
})
