-- Treesitter: https://github.com/nvim-treesitter/nvim-treesitter
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            -- Only install especified parsers
            ensure_installed = {
                "bash",
                "c",
                "cmake",
                "cpp",
                "css",
                "dockerfile",
                "go",
                "gomod",
                "gowork",
                "html",
                "javascript",
                "json",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "rst",
                "rust",
                "scss",
                "toml",
                "vim",
                "yaml",
            },
            highlight = {
                enable = true,
            },
            -- WARN: This feature is not stable yet. See https://github.com/nvim-treesitter/nvim-treesitter#indentation
            -- indent = {
            --     enable = true,
            -- },

            -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
            textobjects = {
                autopairs = { enable = true },
                -- Jump to the next or previous text object
                -- PT-PT keyboards are weird :)
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["ºf"] = "@function.outer",
                        ["ºi"] = "@conditional.inner",
                        ["ºa"] = "@parameter.inner",
                    },
                    goto_next_end = {
                        ["ºF"] = "@function.outer",
                        ["ºI"] = "@conditional.inner",
                        ["ºA"] = "@parameter.inner",
                    },
                    goto_previous_start = {
                        ["çf"] = "@function.outer",
                        ["çi"] = "@conditional.inner",
                        ["ça"] = "@parameter.inner",
                    },
                    goto_previous_end = {
                        ["çF"] = "@function.outer",
                        ["çI"] = "@conditional.inner",
                        ["çA"] = "@parameter.inner",
                    },
                },
                -- Select inner (ix) and all (ax) of a text object
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ab"] = "@block.outer",
                        ["ib"] = "@block.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["ai"] = "@conditional.outer",
                        ["ii"] = "@conditional.inner",
                    },
                },
                -- Swap the node under the cursor
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>a"] = "@parameter.inner",
                        ["<leader>b"] = "@block.outer",
                    },
                    swap_previous = {
                        ["<leader>A"] = "@parameter.inner",
                        ["<leader>B"] = "@block.outer",
                    },
                },
            },
        })
    end,
}
