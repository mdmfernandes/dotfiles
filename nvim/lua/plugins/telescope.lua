-- Telescope: https://github.com/nvim-telescope/telescope.nvim
return {
    "nvim-telescope/telescope.nvim",
    version = "*",
    priority = 100,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "debugloop/telescope-undo.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                layout_config = {
                    width = 0.95,
                    height = 0.9,
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
            },
            pickers = {
                find_files = {
                    find_command = {
                        "fd",
                        "--type",
                        "f",
                        "--strip-cwd-prefix", -- don't show the CWD prefix
                        "--hidden",
                        "--no-ignore",
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
                        width = 0.95,
                        preview_cutoff = 30,
                    },
                    -- don't trim the results
                    -- line_width = 200,
                },
            },
            extensions = {
                file_browser = {
                    hidden = true,
                },
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {}
                },
                undo = {
                    layout_config = {
                        preview_width = 0.75,
                    },
                    mappings = {
                        i = {
                            ["<C-y>"] = require("telescope-undo.actions").yank_additions,
                            ["<S-y>"] = require("telescope-undo.actions").yank_deletions,
                            ["<CR>"] = require("telescope-undo.actions").restore,
                        }
                    }
                }
            },
        })

        -- Load extensions
        telescope.load_extension("fzf")
        telescope.load_extension("file_browser")
        telescope.load_extension("ui-select")
        telescope.load_extension("undo")

        -- Mappings
        local map = require("utils").map
        local tb = require("telescope.builtin")

        map("n", "<C-p>", tb.find_files)
        map("n", "<Leader>/", tb.current_buffer_fuzzy_find)
        map("n", "<Leader>fs", tb.git_files)
        map("n", "<Leader>fg", tb.live_grep)
        -- Grep for string under cursor
        map("n", "<Leader>fc", tb.grep_string)
        -- File browser
        map("n", "<Leader>fb", telescope.extensions.file_browser.file_browser)
        map("n", "<Leader>.", function()
            telescope.extensions.file_browser.file_browser({
                path = "%:p:h",
                hidden = true,             -- show hidden files
                respect_gitignore = false, -- show all files
            })
        end, { desc = "Telescope open file browser in current directory" })
        -- Find symbols
        map("n", "<Leader>ls", tb.treesitter, { desc = "Telescope find document symbols" })
        -- List previously opened files
        map("n", "<Leader>fo", tb.oldfiles)
        -- Search buffers
        map("n", "<Leader>bb", tb.buffers)
        -- Search registers
        map("n", "<Leader>rr", tb.registers)
        -- Git
        map("n", "<Leader>gc", tb.git_commits)
        map("n", "<Leader>gs", tb.git_status)
        -- Diagnostics
        map("n", "<Leader>fd", function() tb.diagnostics({ bufnr = 0 }) end) -- current buffer
        map("n", "<Leader>fD", tb.diagnostics)                               -- all diagnostics from workspace
        -- Undo
        map("n", "<Leader>u", telescope.extensions.undo.undo)
        -- Others
        map("n", "<Leader>fh", tb.help_tags)                       -- nvim help
        map("n", "<Leader>fk", tb.keymaps)                         -- nvim key mappings
        map("n", "<Leader>fn", telescope.extensions.notify.notify) -- show notifications
        map("n", "<Leader>ft", "<Cmd>TodoTelescope<CR>")           -- todo messages
    end
}
