-- Key mappings

-- Map <Leader> to space
vim.g.mapleader = " "

local map = require("utils").map

-- Buffers
map("n", "<Leader>bn", "<Cmd>enew<CR>")
map("n", "<Leader>bz", "<Cmd>only<CR>")
map("n", "<C-q>", "<Cmd>bdelete<CR>")
-- Quickly save the current buffer or all buffers
map("n", "<Leader>w", "<Cmd>update<CR>")
map("n", "<Leader>W", "<Cmd>wall<CR>")

-- Windows
-- Navigate windows
map("", "<C-h>", "<C-w>h")
map("", "<C-j>", "<C-w>j")
map("", "<C-k>", "<C-w>k")
map("", "<C-l>", "<C-w>l")
--- Resize windows
map("n", "<C-Up>", "<Cmd>resize +3<CR>")
map("n", "<C-Down>", "<Cmd>resize -3<CR>")
map("n", "<C-Left>", "<Cmd>vertical resize +3<CR>")
map("n", "<C-Right>", "<Cmd>vertical resize -3<CR>")

-- Tabs
map("n", "<Leader>tn", "<Cmd>tabnew<CR>")
map("n", "<Leader>tq", "<Cmd>tabclose<CR>")
map("n", "<Leader>th", "<Cmd>tabNext<CR>")
map("n", "<Leader>tl", "<Cmd>tabnext<CR>")

-- Move lines around
map("n", "çm", "<Cmd>execute 'move -1-'. v:count1<CR>")
map("v", "<S-k>", ":m '<-2<CR>gv=gv")
map("n", "ºm", "<Cmd>execute 'move +'. v:count1<CR>")
map("v", "<S-j>", ":m '>+1<CR>gv=gv")

-- Add empty lines
map("n", "ç<Space>", "<Cmd>put! =repeat(nr2char(10), v:count1)<CR>")
map("n", "º<Space>", "<Cmd>put =repeat(nr2char(10), v:count1)<CR>")

-- Smart delete - add deleted empty lines to the "_" register
map("n", "dd", function()
    return vim.api.nvim_get_current_line():match("^%s*$") and '"_dd' or "dd"
end, { expr = true })

-- Copy/paste to clipboard
-- Not required if using the "unnamedplus" clipboard
-- map("", "<C-c>", '"+y')
-- map("n", "<Leader>y", '"+y')
-- map("v", "<Leader>y", '"+y')
-- map("n", "<Leader>Y", '"+yg_')
-- map("n", "<Leader>yy", '"+yy')
-- map("n", "<Leader>p", '"+p')
-- map("v", "<Leader>p", '"+p')
-- map("n", "<Leader>P", '"+P')
-- map("v", "<Leader>P", '"+P')

-- Hide search highlights
map("n", "<Leader><Space>", "<Cmd>nohlsearch<CR>")

-- Remove mapping from macros recording and ex mode
map("n", "q", "<Nop>")
map("n", "Q", "<Nop>")

--- Direction keys for wrapped lines
map("n", "k", "gk")
map("n", "j", "gj")
map("n", "<Up>", "gk")
map("n", "<Down>", "gj")
map("i", "<Up>", "<Esc>gka")
map("i", "<Down>", "<Esc>gja")

-- Don't lose selection when shifting
map("x", "<", "<gv")
map("x", ">", ">gv")

-- Move next/previous ocorrence to the middle of the screen
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- Use operator pending mode to visually select the whole buffer
-- e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
map("o", "A", "<Cmd>normal! mzggVG<CR>`z")
map("x", "A", "<Cmd>normal! mzggVG<CR>`z")

-- Toggle spelling
map("", "<F3>", "<Cmd>set spell!<CR>", {})
-- Navigate between spell errors
map("n", "çs", "[s")
map("n", "ºs", "]s")

-- Toggle between paste and nopaste modes
map("", "<F2>", "<Cmd>set paste!<CR>", {})

-- Toogle line wrapping
map("", "<F9>", "<Cmd>set wrap!<CR>", {})

-- Source current file
map("n", "<Leader><CR>", "<Cmd>source %<CR>", {})

-- Health check
map("n", "<Leader>hc", "<Cmd>checkhealth<CR>")

-- Diagnostics
map("n", "çd", vim.diagnostic.goto_prev)
map("n", "ºd", vim.diagnostic.goto_next)
map("n", "<F7>", vim.diagnostic.show)
map("n", "<C-F7>", vim.diagnostic.hide)

-- Navigate between changes
map("n", "çc", "[c")
map("n", "ºc", "]c")
