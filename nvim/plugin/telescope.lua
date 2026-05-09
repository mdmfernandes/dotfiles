-- Telescope: https://github.com/nvim-telescope/telescope.nvim

-- Build FZF native when the plugin state changes
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name == "telescope-fzf-native.nvim" then
            vim.fn.system({ "make", "-C", ev.data.path })
        end
    end,
})

vim.pack.add({
    { src = "https://github.com/nvim-telescope/telescope.nvim",            name = "telescope" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", name = "telescope-fzf-native" },
})

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
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
        },
    },
})

-- Load extensions
telescope.load_extension("fzf")
telescope.load_extension("ui-select")

-- Key Mappings
local tb = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", tb.find_files, { desc = "Telescope find all files" })
vim.keymap.set("n", "<C-s>", tb.git_files, { desc = "Telescope find git files" })
vim.keymap.set("n", "<Leader>/", tb.current_buffer_fuzzy_find)
vim.keymap.set("n", "<Leader>fg", tb.live_grep)
-- Grep for string under cursor
vim.keymap.set("n", "<Leader>fc", tb.grep_string)
-- Find symbols
vim.keymap.set("n", "<Leader>ls", tb.treesitter, { desc = "Telescope find document symbols" })
-- List previously opened files
vim.keymap.set("n", "<Leader>fo", tb.oldfiles, { desc = "List previously open files" })
-- Search buffers
vim.keymap.set("n", "<Leader>bb", tb.buffers, { desc = "List open buffers" })
-- Search registers
vim.keymap.set("n", "<Leader>rr", tb.registers, { desc = "List vim rgisters" })
-- Git
vim.keymap.set("n", "<Leader>gc", tb.git_commits, { desc = "List git commits with diff preview" })
vim.keymap.set(
    "n",
    "<Leader>gs",
    tb.git_status,
    { desc = "List current changes per file with diff preview and add action" }
)
-- Diagnostics
vim.keymap.set("n", "<Leader>fd", function()
    tb.diagnostics({ bufnr = 0 })
end, { desc = "Show diagnostics from current buffer" })
vim.keymap.set("n", "<Leader>fD", tb.diagnostics, { desc = "Show diagnostics from workspace" })
-- Marks
vim.keymap.set("n", "<Leader>fm", tb.marks, { desc = "List vim marks and their value" })
-- Others
vim.keymap.set("n", "<Leader>fh", tb.help_tags, { desc = "List available help tags" })
vim.keymap.set("n", "<Leader>fk", tb.keymaps, { desc = "List key mappings" })
vim.keymap.set("n", "<Leader>fn", telescope.extensions.notify.notify, { desc = "List vim notifications" })
vim.keymap.set("n", "<Leader>ft", "<Cmd>TodoTelescope<CR>", { desc = "List to do comments" })
