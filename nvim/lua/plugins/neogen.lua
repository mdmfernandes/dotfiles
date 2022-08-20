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

-- Create annotation for current function
map("n", "<Leader>af", function()
    neogen.generate({})
end)
-- Create annotation for current class
map("n", "<Leader>ac", function()
    neogen.generate({ type = "class" })
end)
-- Create annotation for current file/document
map("n", "<Leader>ad", function()
    neogen.generate({ type = "file" })
end)
