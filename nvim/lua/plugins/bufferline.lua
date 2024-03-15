-- BufferLine: https://github.com/akinsho/bufferline.nvim
return {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
        { "nvim-tree/nvim-web-devicons", lazy = true },
        "ThePrimeagen/harpoon",
        "catppuccin/nvim"
    },
    config = function()
        require("bufferline").setup({
            highlights = require("catppuccin.groups.integrations.bufferline").get(),
            options = {
                numbers = function(opts)
                    local harpoon_idx = require("harpoon.mark").get_index_of(vim.api.nvim_buf_get_name(opts.id))
                    -- If the file is not marked, don't show the harpoon index
                    harpoon_idx = harpoon_idx and string.format("|%s", opts.raise(harpoon_idx)) or ""
                    return string.format("%s%s", opts.ordinal, harpoon_idx)
                end,
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(_, _, diagnostics_dict, _)
                    local s = " "
                    local signs = require("icons").diagnostics
                    for e, n in pairs(diagnostics_dict) do
                        local sym = e == "error" and signs.Error or (e == "warning" and signs.Warn or signs.Info)
                        s = s .. n .. sym
                    end
                    return s
                end,
                show_buffer_close_icons = false,
                show_close_icon = false,
            }
        })
    end,
    keys = {
        {
            "<S-h>",
            function()
                require("bufferline").cycle(-1)
            end,
            desc = "Go to previous buffer"
        },
        {
            "<S-l>",
            function()
                require("bufferline").cycle(1)
            end,
            desc = "Go to next buffer"
        },
        {
            "<S-Left>",
            function()
                require("bufferline").move(-1)
            end,
            desc = "Move current buffer to the left"
        },
        {
            "<S-Right>",
            function()
                require("bufferline").move(1)
            end,
            desc = "Move current buffer to the right"
        },
        {
            "<Leader>bp",
            function()
                require("bufferline").pick()
            end,
            desc = "Pick a buffer"
        },
        {
            "<Leader>bq",
            function()
                require("bufferline").close_with_pick()
            end,
            desc = "Close a buffer with pick"
        },

        -- Better to use harpoon to move only to buffers of "interest"
        {
            "<Leader>b1",
            function()
                require("bufferline").go_to(1)
            end,
            desc = "Go to buffer in position 1"
        },
        {
            "<Leader>b2",
            function()
                require("bufferline").go_to(2)
            end,
            desc = "Go to buffer in position 2"
        },
        {
            "<Leader>b3",
            function()
                require("bufferline").go_to(3)
            end,
            desc = "Go to buffer in position 3"
        },
        {
            "<Leader>b4",
            function()
                require("bufferline").go_to(4)
            end,
            desc = "Go to buffer in position 4"
        },
        {
            "<Leader>b5",
            function()
                require("bufferline").go_to(5)
            end,
            desc = "Go to buffer in position 5"
        },
        {
            "<Leader>b6",
            function()
                require("bufferline").go_to(6)
            end,
            desc = "Go to buffer in position 6"
        },
        {
            "<Leader>b7",
            function()
                require("bufferline").go_to(7)
            end,
            desc = "Go to buffer in position 7"
        },
        {
            "<Leader>b8",
            function()
                require("bufferline").go_to(8)
            end,
            desc = "Go to buffer in position 8"
        },
        {
            "<Leader>b9",
            function()
                require("bufferline").go_to(9)
            end,
            desc = "Go to buffer in position 9"
        },
    }
}
