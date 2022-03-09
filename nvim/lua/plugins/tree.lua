-- nvim-tree: https://github.com/kyazdani42/nvim-tree.lua
local tree = require("nvim-tree")
tree.setup({
    hijack_cursor = true,
    diagnostics = {
        enable = true,
    },
    filters = {
        custom = { ".git" },
    },
    git = {
        ignore = false,
    },
    view = {
        mappings = {
            list = {
                { key = "<C-h>", action = "split" },
                { key = "ºc", action = "cd" },
                { key = "[g", action = "prev_git_item" },
                { key = "]g", action = "next_git_item" },
            },
        },
    },
})

-- Key Mappings
local map = require("utils").map

map("n", "<C-b>", function() tree.toggle() end)
map("n", "<C-f>", function() tree.toggle(true) end)
