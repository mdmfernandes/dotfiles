-- BufferLine: https://github.com/akinsho/bufferline.nvim
local bufferline = require("bufferline")

bufferline.setup({
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
})

-- Key Mappings
local map = require("utils").map

-- Navigate
map("n", "<S-h>", function()
    bufferline.cycle(-1)
end)
map("n", "<S-l>", function()
    bufferline.cycle(1)
end)
map("n", "<S-Left>", function()
    bufferline.move(-1)
end)
map("n", "<S-Right>", function()
    bufferline.move(1)
end)
map("n", "<Leader>bp", bufferline.pick_buffer)
map("n", "<Leader>bq", bufferline.close_buffer_with_pick)
-- Go to buffer in position
map("n", "<Leader>1", function()
    bufferline.go_to_buffer(1)
end)
map("n", "<Leader>2", function()
    bufferline.go_to_buffer(2)
end)
map("n", "<Leader>3", function()
    bufferline.go_to_buffer(3)
end)
map("n", "<Leader>4", function()
    bufferline.go_to_buffer(4)
end)
map("n", "<Leader>5", function()
    bufferline.go_to_buffer(5)
end)
map("n", "<Leader>6", function()
    bufferline.go_to_buffer(6)
end)
map("n", "<Leader>7", function()
    bufferline.go_to_buffer(7)
end)
map("n", "<Leader>8", function()
    bufferline.go_to_buffer(8)
end)
map("n", "<Leader>9", function()
    bufferline.go_to_buffer(9)
end)
