-- Treesitter: https://github.com/nvim-treesitter/nvim-treesitter
require("nvim-treesitter.configs").setup({
  -- Install all mantained parsers
  --ensure_installed = "maintained",
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
  -- TODO: Try when stable
  --indent = {
  --	enable = true,
  --},

  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  textobjects = {
    -- Select inner (ix) and all (a) of a text object
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["ia"] = "@parameter.inner",
        ["aa"] = "@parameter.outer",
      },
    },
    -- Jump to the next or previous text object
    -- PT-PT keyboards are weird :)
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["ºm"] = "@function.outer",
        ["ºº"] = "@class.outer",
      },
      goto_next_end = {
        ["ºM"] = "@function.outer",
        ["ºç"] = "@class.outer",
      },
      goto_previous_start = {
        ["çm"] = "@function.outer",
        ["çç"] = "@class.outer",
      },
      goto_previous_end = {
        ["çM"] = "@function.outer",
        ["çº"] = "@class.outer",
      },
    },
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
