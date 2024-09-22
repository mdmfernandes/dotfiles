-- Autocommands
local group = vim.api.nvim_create_augroup("CoreGroup", { clear = true })

-- Highlight the region on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 350 })
    end,
})

-- Set format options for all files
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = group,
    pattern = { "*" },
    callback = function()
        -- Remove the following format options:
        -- o - insert comment leader after 'o' or 'O' in Normal mode
        -- r - insert comment leader after hitting <Enter> in Insert mode
        vim.opt_local.formatoptions:remove({ "o", "r" })
    end
})

-- Set commentstring for SELinux files, for commenting the files
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = group,
    pattern = { "selinux" },
    callback = function()
        vim.bo.commentstring = "# %s"
    end,
})
