-- blink.cmp: https://github.com/Saghen/blink.cmp
vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp",            version = "v1", name = "blink.cmp" },
    -- optional: provides snippets for the snippet source
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/fang2hou/blink-copilot" }
})

require("blink.cmp").setup({
    appearance = {
        nerd_font_variant = "mono",
    },
    completion = {
        accept = {
            auto_brackets = {
                enabled = true,
            },
        },
        -- Show documentation when selecting a completion item
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = { border = "rounded" },
        },
        ghost_text = {
            enabled = true,
        },
        list = {
            selection = {
                preselect = function(ctx)
                    return (ctx.mode ~= "cmdline") and not require("blink.cmp").snippet_active({ direction = 1 })
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
                -- Use treesitter to highlight the label text for the given list of sources
                treesitter = { "lsp" },
            },
        },
    },
    keymap = {
        preset = "none",

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
        default = { "lsp", "copilot", "path", "snippets", "buffer" },
        providers = {
            buffer = {
                name = "Buffer",
                module = "blink.cmp.sources.buffer",
                -- max_items = 5,
                -- min_keyword_length = 3,
            },
            copilot = {
                name = "copilot",
                module = "blink-copilot",
                score_offset = 100,
                async = true,
            },
            cmdline = {
                name = "cmdline",
                module = "blink.cmp.sources.cmdline",
                max_items = 10,
                -- min_keyword_length = 1,
            },
        },
    },
    -- Experimental signature help support
    signature = { enabled = true },
})
