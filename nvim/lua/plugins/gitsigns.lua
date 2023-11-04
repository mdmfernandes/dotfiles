-- GitSigns: https://github.com/lewis6991/gitsigns.nvim
return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local map = require("utils").map

        require("gitsigns").setup({
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function buf_map(mode, target, source, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    map(mode, target, source, opts)
                end

                -- Navigation
                buf_map("n", "çg", function()
                    if vim.wo.diff then
                        return "çg"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "Goto previous git hunk" })

                buf_map("n", "ºg", function()
                    if vim.wo.diff then
                        return "ºg"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "Goto next git hunk" })

                -- Actions
                buf_map({ "n", "v" }, "<Leader>ga", gs.stage_hunk, { desc = "Git stage hunk" })
                buf_map({ "n", "v" }, "<Leader>gr", gs.reset_hunk, { desc = "Git reset hunk" })
                buf_map("n", "<Leader>gu", gs.undo_stage_hunk, { desc = "Git undo stage hunk" })
                buf_map("n", "<Leader>gp", gs.preview_hunk, { desc = "Git preview hunk" })
                buf_map("n", "<Leader>gA", gs.stage_buffer, { desc = "Git stage buffer" })
                buf_map("n", "<Leader>gR", gs.reset_buffer, { desc = "Git reset bufferhunk" })
                --buf_map("n", "<Leader>gd", gs.diffthis)
                buf_map("n", "<Leader>gD", function()
                    gs.diffthis("~")
                end, { desc = "Git diff previous commit" })
                buf_map("n", "<Leader>gb", function()
                    gs.blame_line({ full = true })
                end, { desc = "Git blame current line" })
                buf_map("n", "<Leader>gt", gs.toggle_deleted, { desc = "Git toggle deleted source" })

                -- Text objects
                buf_map({ "o", "x" }, "ig", gs.select_hunk, { desc = "Git select current hunk" })
            end,
            -- Git signs
            signs = {
                add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                change = { hl = "GitSignsChange", text = ">", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
                delete = { hl = "GitSignsDelete", text = "-", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                topdelete = { hl = "GitSignsDelete", text = "^", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                changedelete = {
                    hl = "GitSignsChange",
                    text = "<",
                    numhl = "GitSignsChangeNr",
                    linehl = "GitSignsChangeLn"
                },
            },
        })
    end
}
