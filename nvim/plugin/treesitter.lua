-- Treesitter: https://github.com/nvim-treesitter/nvim-treesitter

-- Run `:TSUpdate` (update parsers) when the plugin changes
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name ~= "nvim-treesitter" then
            return
        end
        if ev.data.kind ~= "update" then
            return
        end
        if not ev.data.active then
            vim.cmd.packadd("nvim-treesitter")
        end
        vim.cmd("TSUpdate")
    end,
})

-- Tree-sitter SELinux parser
vim.api.nvim_create_autocmd("User", {
    pattern = "TSUpdate",
    callback = function()
        require("nvim-treesitter.parsers").selinux = {
            install_info = {
                url = "https://github.com/mdmfernandes/tree-sitter-selinux", -- local path or git repo
                files = { "src/parser.c" },
                branch = "main",
                -- revision = "HEAD",
                generate_requires_npm = false,          -- if stand-alone parser without npm dependencies
                requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
                queries = "queries",                    -- also install queries from given directory
            },
        }
    end
})

vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter",            name = "treesitter" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
})

require("nvim-treesitter").setup({
    -- Only install specified parsers
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
        -- "dockerfile", -- Not good
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

    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    textobjects = {
        autopairs = { enable = true },
        -- Jump to the next or previous text object
        -- PT-PT keyboards are weird :)
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]f"] = "@function.outer",
                ["]i"] = "@conditional.inner",
                ["]a"] = "@parameter.inner",
            },
            goto_next_end = {
                ["]F"] = "@function.outer",
                ["]I"] = "@conditional.inner",
                ["]A"] = "@parameter.inner",
            },
            goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[i"] = "@conditional.inner",
                ["[a"] = "@parameter.inner",
            },
            goto_previous_end = {
                ["[F"] = "@function.outer",
                ["[I"] = "@conditional.inner",
                ["[A"] = "@parameter.inner",
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
    },
})
