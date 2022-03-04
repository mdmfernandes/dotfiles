-- Git
local u = require("core.utils")

-- NeoGit: https://github.com/TimUntersberger/neogit
require("neogit").setup({
  integrations = {
    diffview = true,
  },
})

-- Key mappings
u.map("n", "<Leader>gs", "<Cmd>Neogit<CR>") -- Git status
u.map("n", "<Leader>gd", "<Cmd>DiffviewOpen<CR>")
u.map("n", "<Leader>gh", "<Cmd>DiffviewFileHistory<CR>")
u.map("n", "<Leader>gx", "<Cmd>DiffviewClose<CR>")

-- GitSigns: https://github.com/lewis6991/gitsigns.nvim
-- TODO: Update for NeoVIM 0.7.0+: https://github.com/lewis6991/gitsigns.nvim#keymaps
require("gitsigns").setup({
  on_attach = function(bufnr)
    -- Navigation
    u.buf_map(bufnr, "n", "<Leader>gp", "&diff ? '[c' : '<Cmd>Gitsigns prev_hunk<CR>'", { expr = true })
    u.buf_map(bufnr, "n", "<Leader>gn", "&diff ? ']c' : '<Cmd>Gitsigns next_hunk<CR>'", { expr = true })

    -- Actions
    u.buf_map(bufnr, "n", "<Leader>ga", ":Gitsigns stage_hunk<CR>")
    u.buf_map(bufnr, "v", "<Leader>ga", ":Gitsigns stage_hunk<CR>")
    u.buf_map(bufnr, "n", "<Leader>gr", ":Gitsigns reset_hunk<CR>")
    u.buf_map(bufnr, "v", "<Leader>gr", ":Gitsigns reset_hunk<CR>")
    u.buf_map(bufnr, "n", "<Leader>gu", "<Cmd>Gitsigns undo_stage_hunk<CR>")
    u.buf_map(bufnr, "n", "<Leader>gg", "<Cmd>Gitsigns preview_hunk<CR>")
    u.buf_map(bufnr, "n", "<Leader>gA", "<Cmd>Gitsigns stage_buffer<CR>")
    u.buf_map(bufnr, "n", "<Leader>gR", "<Cmd>Gitsigns reset_buffer<CR>")
    --u.buf_map(bufnr, "n", "<Leader>gd", "<Cmd>Gitsigns diffthis<CR>")
    u.buf_map(bufnr, "n", "<Leader>gD", '<Cmd>lua require"gitsigns".diffthis("~")<CR>')
    u.buf_map(bufnr, "n", "<Leader>gt", "<Cmd>Gitsigns toggle_deleted<CR>")
  end,

  -- Git signs
  signs = {
    add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = ">", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "-", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "^", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "<", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
})
