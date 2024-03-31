-- Key mappings

-- Leader key -> <Space>
-- Make sure this is set before loading the plugins
vim.g.mapleader = " "

local map = require("utils").map

-- Buffers
map("n", "<Leader>bn", "<Cmd>enew<CR>")
map("n", "<Leader>bz", "<Cmd>only<CR>")
map("n", "<C-q>", "<Cmd>bdelete<CR>")

--- Resize windows
map("n", "<C-Up>", "<Cmd>resize +3<CR>")
map("n", "<C-Down>", "<Cmd>resize -3<CR>")
map("n", "<C-Left>", "<Cmd>vertical resize +3<CR>")
map("n", "<C-Right>", "<Cmd>vertical resize -3<CR>")

-- Files
-- Edit the alternate file, which typically is the previously edited file.
map("n", "<C-\\>", "<Cmd>e #<CR>")

-- Move lines around
map("n", "çm", "<Cmd>execute 'move -1-'. v:count1<CR>")
map("v", "<S-k>", ":m '<-2<CR>gv=gv")
map("n", "ºm", "<Cmd>execute 'move +'. v:count1<CR>")
map("v", "<S-j>", ":m '>+1<CR>gv=gv")

-- Add empty lines
map("n", "ç<Space>", "<Cmd>put! =repeat(nr2char(10), v:count1)<CR>")
map("n", "º<Space>", "<Cmd>put =repeat(nr2char(10), v:count1)<CR>")

-- Smart delete - add deleted empty lines to the  blackhole ("_") register
map("n", "dd", function()
    return vim.api.nvim_get_current_line():match("^%s*$") and '"_dd' or "dd"
end, { expr = true, desc = "delete current line" })

-- Change/delete/substitute/yank into blackhole buffer
-- Change
map("n", "<Leader>c", '"_c')
map("v", "<Leader>c", '"_c')
map("n", "<Leader>C", '"_C')
map("v", "<Leader>C", '"_C')
-- Delete
map("n", "<Leader>d", '"_d')
map("v", "<Leader>d", '"_d')
map("n", "<Leader>D", '"_D')
map("v", "<Leader>D", '"_D')
-- Substitute
map("n", "<Leader>s", '"_s')
map("v", "<Leader>s", '"_s')
map("n", "<Leader>S", '"_S')
map("v", "<Leader>S", '"_S')

-- Hide search highlights
map("n", "<Leader><Space>", "<Cmd>nohlsearch<CR>")

-- Remove mapping from macros recording and ex mode
map("n", "q", "<Nop>")
map("n", "Q", "<Nop>")

-- Don't lose selection when shifting
map("x", "<", "<gv")
map("x", ">", ">gv")

-- Move next/previous occurrence to the middle of the screen
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- Use operator pending mode to visually select the whole buffer (All)
-- e.g. dA = delete whole buffer, yA = copy whole buffer
map("o", "A", "<Cmd>normal! mzggVG<CR>`z")
map("x", "A", "<Cmd>normal! mzggVG<CR>`z")

-- Navigation
-- Navigate between spell errors
map("n", "çs", "[s")
map("n", "ºs", "]s")
-- Navigate between changes
map("n", "çc", "[c")
map("n", "ºc", "]c")

-- Diagnostics
map("n", "çd", vim.diagnostic.goto_prev)
map("n", "ºd", vim.diagnostic.goto_next)
map("n", "<F7>", function()
    vim.diagnostic.show()
    vim.notify(string.format("Show diagnostics"), vim.log.levels.INFO)
end, { desc = "Show diagnostics" })
map("n", "<C-F7>", function()
    vim.diagnostic.hide()
    vim.notify(string.format("Hide diagnostics"), vim.log.levels.INFO)
end, { desc = "Hide diagnostics" })

-- Make current file executable to current user
map("n", "<Leader>x", function()
    vim.cmd("!chmod u+x %")
    vim.notify(string.format("Changing file '%s' to executable (u+x)!", vim.fn.expand("%:p")), vim.log.levels.INFO)
end, { desc = "Change current file to executable (u+x)" })
