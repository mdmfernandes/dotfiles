-- Neogen: https://github.com/danymat/neogen
local neogen = require("neogen")

neogen.setup({
    snippet_engine = "luasnip",
    languages = {
        python = {
            template = {
                annotation_convention = "reST",
            },
        },
    },
})

-- Key Mappings
local map = require("utils").map

map("n", "<Leader>nf", function()
    neogen.generate()
end)
map("n", "<Leader>nc", function()
    neogen.generate({ type = "class" })
end)
