-- NeoGit: https://github.com/TimUntersberger/neogit
local neogit = require("neogit")

neogit.setup({
    integrations = {
        diffview = true,
    },
})

-- Key Mappings
local map = require("utils").map

map("n", "<Leader>gg", neogit.open)
