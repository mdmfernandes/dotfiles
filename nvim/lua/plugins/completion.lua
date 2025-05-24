-- blink.cmp: https://github.com/Saghen/blink.cmp
return {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",

    -- use a release tag to download pre-built binaries
    version = "1.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        appearance = {
            nerd_font_variant = "mono"
        },
        completion = {
            -- Show documentation when selecting a completion item
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
                window = { border = "rounded" }
            },
            -- ghost_text = {
            --     enabled = true,
            -- },
            list = {
                selection = {
                    preselect = function(ctx)
                        return (ctx.mode ~= "cmdline") and not require("blink.cmp").snippet_active { direction = 1 }
                    end,
                    auto_insert = function(ctx)
                        return ctx.mode ~= "cmdline"
                    end,
                },
            },
            menu = {
                -- Show provider of the completion
                draw = {
                    columns = {
                        { "kind_icon" },
                        { "label",    "label_description", gap = 1 },
                        { "provider" },
                    },
                    components = {
                        provider = {
                            text = function(ctx)
                                return ctx.item.source_name:sub(1, 3):upper()
                            end,
                        },
                    },
                },
            },
        },
        keymap = {
            preset = "enter",

            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-e>"] = { "hide", "fallback" },
            ["<CR>"] = { "accept", "fallback" },

            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },

            ["<C-l>"] = { "snippet_forward", "fallback" },
            ["<C-h>"] = { "snippet_backward", "fallback" },

            ["<C-k>"] = { "scroll_documentation_up", "fallback" },
            ["<C-j>"] = { "scroll_documentation_down", "fallback" },

        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {
                buffer = {
                    name = "Buffer",
                    module = "blink.cmp.sources.buffer",
                    -- max_items = 5,
                    min_keyword_length = 3,
                },
                cmdline = {
                    name = "cmdline",
                    module = "blink.cmp.sources.cmdline",
                    max_items = 10,
                    min_keyword_length = 3,
                },
            },
        },
        -- Experimental signature help support
        signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
}
