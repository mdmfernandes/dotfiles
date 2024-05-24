-- Autocommands
local group = vim.api.nvim_create_augroup("CoreGroup", { clear = true })

-- Highlight the region on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 350 })
    end,
})

-- Set commentstring for SELinux files, for commenting the files
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = group,
    pattern = { "selinux" },
    callback = function()
        vim.bo.commentstring = "# %s"
    end,
})
