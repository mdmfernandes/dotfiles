-- Treesitter: https://github.com/nvim-treesitter/nvim-treesitter
require("nvim-treesitter.configs").setup({
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
        "python",
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
                ["av"] = "@parameter.outer",
                ["iv"] = "@parameter.inner",
                ["ai"] = "@conditional.outer",
                ["ii"] = "@conditional.inner",
            },
        },
        -- Swap the node under the cursor
        swap = {
            enable = true,
            swap_next = {
                ["<leader>v"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>V"] = "@parameter.inner",
            },
        },
        -- Jump to the next or previous text object
        -- PT-PT keyboards are weird :)
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["ºf"] = "@function.outer",
                ["ºi"] = "@conditional.inner",
                ["ºv"] = "@parameter.inner",
            },
            goto_next_end = {
                ["ºF"] = "@function.outer",
                ["ºI"] = "@conditional.inner",
                ["ºV"] = "@parameter.inner",
            },
            goto_previous_start = {
                ["çf"] = "@function.outer",
                ["çi"] = "@conditional.inner",
                ["çv"] = "@parameter.inner",
            },
            goto_previous_end = {
                ["çF"] = "@function.outer",
                ["çI"] = "@conditional.inner",
                ["çV"] = "@parameter.inner",
            },
        },
        autopairs = { enable = true },
        -- Peek definitions of functions and classes
        lsp_interop = {
            enable = true,
            border = "rounded",
            peek_definition_code = {
                ["df"] = "@function.outer",
                ["dF"] = "@class.outer",
            },
        },
    },
})
