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
                "asm",
                "bash",
                "bitbake",
                "c",
                "cmake",
                -- "comment", -- I'm using todo-comments plugin
                "cpp",
                "css",
                "csv",
                "diff",
                "dockerfile",
                "doxygen",
                "fidl",
                "git_config",
                "git_rebase",
                "gitcommit",
                "gitignore",
                "go",
                "gomod",
                "gosum",
                "gowork",
                "gpg",
                "graphql",
                "html",
                "http",
                "ini",
                "javascript",
                "jq",
                "json",
                "kconfig",
                "lua",
                "luap",
                "make",
                "markdown",
                "markdown_inline",
                "mermaid",
                "ninja",
                "objdump",
                "passwd",
                "python",
                "query",
                "regex",
                "rst",
                "rust",
                "scss",
                "sql",
                "ssh_config",
                "strace",
                "tmux",
                "toml",
                "udev",
                "vim",
                "vimdoc",
                "xml",
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
    init = function()
        -- Tree-sitter selinux parser
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.selinux = {
            install_info = {
                url = "~/src/tree-sitter-selinux", -- local path or git repo
                files = { "src/parser.c" },
                -- optional entries:
                branch = "main",
                generate_requires_npm = false,          -- if stand-alone parser without npm dependencies
                requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
            },
        }
    end,
}
