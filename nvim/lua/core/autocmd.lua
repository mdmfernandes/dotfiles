-- Autocommands
local my_au = vim.api.nvim_create_augroup("MyGroup", { clear = true })

-- Highlight the region on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = my_au,
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 350 })
    end,
})

-- -- Show current cursor diagnostics
-- vim.api.nvim_create_autocmd("CursorHold", {
--     group = my_au,
--     callback = function()
--         vim.diagnostic.open_float(nil, { focusable = false, scope = "cursor" })
--     end,
-- })

-- Set spell for certain file types
-- Currently, it's enabled for all file types. See core/options.lua
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--     group = my_au,
--     pattern = { "NeogitCommitMessage", "gitcommit", "markdown" },
--     callback = function()
--         vim.opt_local.spell = true
--     end,
-- })
