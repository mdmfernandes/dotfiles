-- Treesitter: https://github.com/nvim-treesitter/nvim-treesitter
--             https://github.com/nvim-treesitter/nvim-treesitter-textobjects

-- Run `:TSUpdate` (update parsers) when the plugin changes
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name ~= "treesitter" then
            return
        end
        if ev.data.kind ~= "update" then
            return
        end
        if not ev.data.active then
            vim.cmd.packadd("treesitter")
        end
        vim.cmd("TSUpdate")
    end,
})

-- Tree-sitter SELinux parser
-- vim.api.nvim_create_autocmd("User", {
--     pattern = "TSUpdate",
--     callback = function()
--         require("nvim-treesitter.parsers").selinux = {
--             install_info = {
--                 url = "https://github.com/mdmfernandes/tree-sitter-selinux", -- local path or git repo
--                 files = { "src/parser.c" },
--                 branch = "main",
--                 -- revision = "HEAD",
--                 generate_requires_npm = false,          -- if stand-alone parser without npm dependencies
--                 requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
--                 queries = "queries",                    -- also install queries from given directory
--             },
--         }
--     end
-- })

vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter",            name = "treesitter" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
})

local parsers = {
    "asm",
    "bash",
    "bitbake",
    "c",
    "cmake",
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
    "toml",
    "udev",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
}

local treesitter = require("nvim-treesitter")
treesitter.setup()
treesitter.install(parsers)

require("nvim-treesitter-textobjects").setup({
    select = {
        lookahead = true,
    },
    move = {
        set_jumps = true,
    },
})

local ts_select = require("nvim-treesitter-textobjects.select")
local ts_move = require("nvim-treesitter-textobjects.move")

-- Select inner (ix) and all (ax) of a text object.
local function map_select(lhs, capture)
    vim.keymap.set({ "x", "o" }, lhs, function()
        ts_select.select_textobject(capture, "textobjects")
    end)
end

for lhs, capture in pairs({
    ["af"] = "@function.outer",
    ["if"] = "@function.inner",
    ["ab"] = "@block.outer",
    ["ib"] = "@block.inner",
    ["al"] = "@loop.outer",
    ["il"] = "@loop.inner",
    ["aa"] = "@parameter.outer",
    ["ia"] = "@parameter.inner",
    ["ac"] = "@conditional.outer",
    ["ic"] = "@conditional.inner",
}) do
    map_select(lhs, capture)
end

-- Jump to the next or previous text object.
local function map_move(lhs, method, capture)
    vim.keymap.set({ "n", "x", "o" }, lhs, function()
        ts_move[method](capture, "textobjects")
    end)
end

for lhs, capture in pairs({
    ["]f"] = "@function.outer",
    ["]c"] = "@conditional.inner",
    ["]a"] = "@parameter.inner",
}) do
    map_move(lhs, "goto_next_start", capture)
end

for lhs, capture in pairs({
    ["]F"] = "@function.outer",
    ["]C"] = "@conditional.inner",
    ["]A"] = "@parameter.inner",
}) do
    map_move(lhs, "goto_next_end", capture)
end

for lhs, capture in pairs({
    ["[f"] = "@function.outer",
    ["[c"] = "@conditional.inner",
    ["[a"] = "@parameter.inner",
}) do
    map_move(lhs, "goto_previous_start", capture)
end

for lhs, capture in pairs({
    ["[F"] = "@function.outer",
    ["[C"] = "@conditional.inner",
    ["[A"] = "@parameter.inner",
}) do
    map_move(lhs, "goto_previous_end", capture)
end
