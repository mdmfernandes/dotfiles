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
-- map("n", "[m", "<Cmd>execute 'move -1-'. v:count1<CR>")
-- map("v", "<S-k>", ":m '<-2<CR>gv=gv")
-- map("n", "]m", "<Cmd>execute 'move +'. v:count1<CR>")
-- map("v", "<S-j>", ":m '>+1<CR>gv=gv")

-- Add empty lines
map("n", "[<Space>", "<Cmd>put! =repeat(nr2char(10), v:count1)<CR>")
map("n", "]<Space>", "<Cmd>put =repeat(nr2char(10), v:count1)<CR>")

-- Smart delete - add deleted empty lines to the black hole ("_") register
map("n", "dd", function()
    return vim.api.nvim_get_current_line():match("^%s*$") and '"_dd' or "dd"
end, { expr = true, desc = "delete current line" })

-- Hide search highlights
map("n", "<Leader><Space>", "<Cmd>nohlsearch<CR>")

-- Remove mapping from macros recording, ex mode, F1
map("n", "q", "<Nop>")
map("n", "Q", "<Nop>")
map({ "n", "i", "v" }, "<F1>", "<Nop>")

-- Don't lose selection when shifting
map("x", "<", "<gv")
map("x", ">", ">gv")

-- Move next/previous occurrence to the middle of the screen
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- Use operator pending mode to visually select the whole buffer (All)
-- e.g. dA = delete whole buffer, yA = copy whole buffer
map("o", "A", "<Cmd>normal! mzggVG<CR>`z")
map("x", "A", "<Cmd>normal! ggVG<CR>")

-- Diagnostics (center diagnostic in the screen)
map("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
    vim.cmd("normal! zz")
end, { desc = "Go to previous diagnostic" })
map("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
    vim.cmd("normal! zz")
end, { desc = "Go to next diagnostic" })

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

-- Status of LSPs / formatters / linters
map("n", "<Leader>\\", require("core.status").setup, { desc = "Print active LSP sources, formatters, and linters" })
