-- Telescope: https://github.com/nvim-telescope/telescope.nvim
local telescope = require("telescope")

telescope.setup({
    defaults = {
        layout_config = {
            width = 0.9,
            preview_cutoff = 120,
            horizontal = { preview_width = 0.55 },
        },
        --sorting_strategy = "ascending",
        file_ignore_patterns = { ".git/", "node_modules/" },
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
                ".git/",
                "--exclude",
                "node_modules/",
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
telescope.load_extension("fzf")
telescope.load_extension("file_browser")

-- Mappings
local map = require("utils").map
local tb = require("telescope.builtin")

map("n", "gf", tb.find_files)
map("n", "<Leader>ff", tb.current_buffer_fuzzy_find)
map("n", "<Leader>fs", tb.git_files)
map("n", "<Leader>fg", tb.live_grep)
-- Grep for string under cursor
map("n", "<Leader>fc", tb.grep_string)
map("n", "<Leader>fb", telescope.extensions.file_browser.file_browser)
-- Find symbols
map("n", "<Leader>fy", tb.treesitter)
-- List previously opened files
map("n", "<Leader>fo", tb.oldfiles)
-- Search buffers
map("n", "<Leader>bb", tb.buffers)
-- Search registers
map("n", "<Leader>rr", tb.registers)
-- Git
map("n", "<Leader>gc", tb.git_commits)
map("n", "<Leader>gs", tb.git_status)
-- Others
map("n", "<Leader>fh", tb.help_tags)
map("n", "<Leader>fm", tb.man_pages)
map("n", "<Leader>fk", tb.keymaps)
map("n", "<Leader>ft", "<Cmd>TodoTelescope<CR>")
