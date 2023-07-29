-- BufferLine: https://github.com/akinsho/bufferline.nvim
return {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
    opts = {
        options = {
            numbers = function(opts)
                return string.format("%s:", opts.ordinal)
            end,
            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(_, _, diagnostics_dict, _)
                local s = " "
                for e, n in pairs(diagnostics_dict) do
                    local sym = e == "error" and " " or (e == "warning" and " " or " ")
                    s = s .. n .. sym
                end
                return s
            end,
            show_buffer_close_icons = false,
            show_close_icon = false,
        },
    },
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
                require("bufferline").pick_buffer()
            end,
            desc = "Pick a buffer"
        },
        {
            "<Leader>bq",
            function()
                require("bufferline").close_buffer_with_pick()
            end,
            desc = "Close a buffer with pick"
        },
        {
            "<Leader>1",
            function()
                require("bufferline").go_to_buffer(1)
            end,
            desc = "Go to buffer in position 1"
        },
        {
            "<Leader>2",
            function()
                require("bufferline").go_to_buffer(2)
            end,
            desc = "Go to buffer in position 2"
        },
        {
            "<Leader>3",
            function()
                require("bufferline").go_to_buffer(3)
            end,
            desc = "Go to buffer in position 3"
        },
        {
            "<Leader>4",
            function()
                require("bufferline").go_to_buffer(4)
            end,
            desc = "Go to buffer in position 4"
        },
        {
            "<Leader>5",
            function()
                require("bufferline").go_to_buffer(5)
            end,
            desc = "Go to buffer in position 5"
        },
        {
            "<Leader>6",
            function()
                require("bufferline").go_to_buffer(6)
            end,
            desc = "Go to buffer in position 6"
        },
        {
            "<Leader>7",
            function()
                require("bufferline").go_to_buffer(7)
            end,
            desc = "Go to buffer in position 7"
        },
        {
            "<Leader>8",
            function()
                require("bufferline").go_to_buffer(8)
            end,
            desc = "Go to buffer in position 8"
        },
        {
            "<Leader>9",
            function()
                require("bufferline").go_to_buffer(9)
            end,
            desc = "Go to buffer in position 9"
        },
    }
}
