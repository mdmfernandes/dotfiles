-- Key mappings

-- Leader key -> <Space>
-- Make sure this is set before loading the plugins
vim.g.mapleader = " "

-- Buffers
vim.keymap.set("n", "<Leader>bn", "<Cmd>enew<CR>")
vim.keymap.set("n", "<Leader>bz", "<Cmd>only<CR>")
vim.keymap.set("n", "<C-q>", "<Cmd>bdelete<CR>")

--- Resize windows
vim.keymap.set("n", "<C-Up>", "<Cmd>resize +3<CR>")
vim.keymap.set("n", "<C-Down>", "<Cmd>resize -3<CR>")
vim.keymap.set("n", "<C-Left>", "<Cmd>vertical resize +3<CR>")
vim.keymap.set("n", "<C-Right>", "<Cmd>vertical resize -3<CR>")

-- Files
-- Edit the alternate file, which typically is the previously edited file.
vim.keymap.set("n", "<C-\\>", "<Cmd>e #<CR>")

-- Add empty lines
vim.keymap.set("n", "[<Space>", "<Cmd>put! =repeat(nr2char(10), v:count1)<CR>")
vim.keymap.set("n", "]<Space>", "<Cmd>put =repeat(nr2char(10), v:count1)<CR>")

-- Smart delete - add deleted empty lines to the black hole ("_") register
vim.keymap.set("n", "dd", function()
    return vim.api.nvim_get_current_line():match("^%s*$") and '"_dd' or "dd"
end, { expr = true, desc = "delete current line" })

-- Hide search highlights
vim.keymap.set("n", "<Leader><Space>", "<Cmd>nohlsearch<CR>")

-- Remove mapping from macros recording, ex mode, F1
vim.keymap.set("n", "q", "<Nop>")
vim.keymap.set("n", "Q", "<Nop>")
vim.keymap.set({ "n", "i", "v" }, "<F1>", "<Nop>")

-- Don't lose selection when shifting
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Move next/previous occurrence to the middle of the screen
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Use operator pending mode to visually select the whole buffer (All)
-- e.g. dA = delete whole buffer, yA = copy whole buffer
vim.keymap.set("o", "A", "<Cmd>normal! mzggVG<CR>`z")
vim.keymap.set("x", "A", "<Cmd>normal! ggVG<CR>")

-- Diagnostics navigation - center diagnostic in the screen and ignore hints
vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, severity = { min = vim.diagnostic.severity.INFO }, float = true })
    vim.cmd("normal! zz")
end, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, severity = { min = vim.diagnostic.severity.INFO }, float = true })
    vim.cmd("normal! zz")
end, { desc = "Go to next diagnostic" })

-- Diagnostics show / hide
vim.keymap.set("n", "<F7>", function()
    vim.diagnostic.show()
    vim.notify(string.format("Show diagnostics"), vim.log.levels.INFO)
end, { desc = "Show diagnostics" })
vim.keymap.set("n", "<F8>", function()
    vim.diagnostic.hide()
    vim.notify(string.format("Hide diagnostics"), vim.log.levels.INFO)
end, { desc = "Hide diagnostics" })

-- Make current file executable to current user
vim.keymap.set("n", "<Leader>x", function()
    vim.cmd("!chmod u+x %")
    vim.notify(string.format("Changing file '%s' to executable (u+x)!", vim.fn.expand("%:p")), vim.log.levels.INFO)
end, { desc = "Change current file to executable (u+x)" })

-- Status of LSPs / formatters / linters
vim.keymap.set("n", "<Leader>\\", require("core.status").setup, { desc = "Print active LSP sources, formatters, and linters" })
