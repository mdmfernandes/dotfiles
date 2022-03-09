-- nvim-cmp: https://github.com/hrsh7th/nvim-cmp
-- luasnip: https://github.com/L3MON4D3/LuaSnip
local cmp = require("cmp")
local luasnip = require("luasnip")

-- local has_words_before = function()
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    formatting = {
        format = function(entry, vim_item)
            -- Completion kind symbols
            local symbols_map = {
                Text = "",
                Method = "",
                Function = "",
                Constructor = "",
                Field = "ﰠ",
                Variable = "",
                Class = "ﴯ",
                Interface = "",
                Module = "",
                Property = "ﰠ",
                Unit = "",
                Value = "",
                Enum = "",
                Keyword = "",
                Snippet = "",
                Color = "",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "",
                Struct = "",
                Event = "",
                Operator = "",
                TypeParameter = "",
            }

            -- Show item symbol and kind, e.g. " Funcion"
            vim_item.kind = string.format("%s %s", symbols_map[vim_item.kind], vim_item.kind)

            local alias = {
                buffer = "Buffer",
                luasnip = "LuaSnip",
                nvim_lsp = "LSP",
                path = "Path",
            }

            -- If the source is a LSP, show its name instead of the string "LSP"
            if entry.source.name == "nvim_lsp" then
                vim_item.menu = entry.source.source.client.name
            else
                vim_item.menu = alias[entry.source.name] or entry.source.name
            end

            return vim_item
        end,
    },
    mapping = {
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
                -- elseif has_words_before() then
                --     cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp", max_item_count = 10 },
        { name = "luasnip", max_item_count = 10 },
        { name = "buffer", max_item_count = 10 },
        { name = "path", max_item_count = 10 },
    }),
})

-- Use buffer source for forward-search in command line
cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" },
    },
})

-- Use buffer source for backward-search in command line
cmp.setup.cmdline("?", {
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' in command line
--[[ cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    },
    {
        { name = 'cmdline' }
    })
}) ]]
