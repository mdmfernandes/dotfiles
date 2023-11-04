-- LuaSnip: https://github.com/L3MON4D3/LuaSnip
-- Friendly Snippets: https://github.com/rafamadriz/friendly-snippets
return {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()
    end
}
