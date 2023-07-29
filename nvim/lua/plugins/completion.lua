-- nvim-cmp: https://github.com/hrsh7th/nvim-cmp
return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",                                              -- buffer completions
            "hrsh7th/cmp-cmdline",                                             -- cmdline completions
            "hrsh7th/cmp-nvim-lsp",                                            -- language-server-based completions
            "hrsh7th/cmp-nvim-lsp-signature-help",                             -- function signatures
            "hrsh7th/cmp-nvim-lua",                                            -- nvim Lua API completions
            "hrsh7th/cmp-path",                                                -- path completions
            { "saadparwaiz1/cmp_luasnip", dependencies = "L3MON4D3/LuaSnip" }, -- completion engine
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

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
                            nvim_lua = "API",
                            path = "Path",
                        }

                        -- If the source is a LSP, show its name instead of the string "LSP"
                        if entry.source.name == "nvim_lsp" then
                            vim_item.menu = alias[entry.source.name] .. "(" .. entry.source.source.client.name .. ")"
                            -- If the source is the signature help, don't show its name
                        elseif entry.source.name == "nvim_lsp_signature_help" then
                            vim_item.menu = nil
                        else
                            vim_item.menu = alias[entry.source.name] or entry.source.name
                        end

                        return vim_item
                    end,
                },
                mapping = {
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-e>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.abort()
                        else
                            cmp.complete()
                        end
                    end),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
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
                    { name = "nvim_lua" },
                    { name = "nvim_lsp" },
                    {
                        name = "luasnip",
                        keyword_length = 2,
                        max_item_count = 6
                    },
                    {
                        name = "buffer",
                        option = {
                            get_bufnrs = function()
                                return vim.api.nvim_list_bufs()
                            end,
                        },
                        keyword_length = 3,
                        max_item_count = 7,
                    },
                    {
                        name = "path",
                        max_item_count = 7
                    },
                    { name = "nvim_lsp_signature_help" },
                }),
            })

            -- Use buffer source for forward-search in command line
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            -- Use buffer source for backward-search in command line
            cmp.setup.cmdline("?", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            -- Use cmdline & path source for ':' in command line
            -- cmp.setup.cmdline(":", {
            --     sources = cmp.config.sources({
            --             { name = "path" }
            --         },
            --         {
            --             { name = "cmdline" }
            --         })
            -- })
        end
    },
}
