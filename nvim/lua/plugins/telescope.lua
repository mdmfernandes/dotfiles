-- Telescope: https://github.com/nvim-telescope/telescope.nvim
local u = require("core.utils")

require("telescope").setup({
  defaults = {
    -- wrap_results = true,
    layout_config = {
      width = 0.9,
      preview_cutoff = 120,
      horizontal = { preview_width = 0.55 },
    },
    --sorting_strategy = "ascending",
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob", -- ignore the .git directory
      "!.git/",
      "--glob",
      "!node_modules/",
    },
    mappings = {
      i = {
        -- No "normal" mode in Telescope
        ["<ESC>"] = require("telescope.actions").close,
        -- Use Ctrl-u to clear the buffer
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
  pickers = {
    find_files = {
      find_command = {
        "fd",
        "--type",
        "f",
        "--strip-cwd-prefix", -- don't show the CWD prefix
        "--hidden",
        "--exclude",
        ".git",
        "--exclude",
        "node_modules",
      },
    },
    diagnostics = {
      wrap_results = false,
      layout_strategy = "vertical",
      layout_config = {
        width = 0.9,
        preview_cutoff = 30,
      },
      -- don't trim the results
      line_width = 200,
    },
  },
  extensions = {
    file_browser = {
      hidden = true,
    },
  },
})

-- Extensions
require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")

-- Key mappings
u.map("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>")
u.map("n", "<Leader>fs", "<Cmd>Telescope git_files<CR>")
u.map("n", "<Leader>fg", "<Cmd>Telescope live_grep<CR>")
u.map("n", "<Leader>fc", "<Cmd>Telescope grep_string<CR>") -- Grep for string under cursor
u.map("n", "<Leader>fb", "<Cmd>Telescope file_browser<CR>")
u.map("n", "<Leader>fy", "<Cmd>Telescope treesitter<CR>") -- Find symbols
u.map("n", "<Leader>fo", "<Cmd>Telescope oldfiles<CR>") -- List previously opened files
u.map("n", "<Leader>bs", "<Cmd>Telescope buffers<CR>") -- Search buffers
u.map("n", "<Leader>fh", "<Cmd>Telescope help_tags<CR>")
u.map("n", "<Leader>fm", "<Cmd>Telescope man_pages<CR>")

-- Commands
-- TODO: Add this when NeoVIM >= 0.7.0
--u.command("HelpTags", "Telescope help_tags")
--u.command("ManPages", "Telescope man_pages")
