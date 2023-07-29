-- Neogen: https://github.com/danymat/neogen
return {
    "danymat/neogen",
    dependencies = {
        "L3MON4D3/LuaSnip",
        "nvim-treesitter/nvim-treesitter"
    },
    version = "*", -- Only follow stable versions
    opts = {
        snippet_engine = "luasnip",
        languages = {
            python = {
                template = {
                    annotation_convention = "reST",
                },
            },
        },
    },
    keys = {
        {
            "<Leader>af",
            function()
                require("neogen").generate({})
            end,
            desc = "Annotate current function"
        },
        {
            "<Leader>ac",
            function()
                require("neogen").generate({ type = "class" })
            end,
            desc = "Annotate current class"
        },
        {
            "<Leader>ad",
            function()
                require("neogen").generate({ type = "file" })
            end,
            desc = "Annotate current file"
        },
    },
}
