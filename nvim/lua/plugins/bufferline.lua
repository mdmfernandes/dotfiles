-- BufferLine: https://github.com/akinsho/bufferline.nvim
local u = require("core.utils")

require("bufferline").setup({
  options = {
    numbers = function(opts)
      return string.format("%s:", opts.ordinal)
    end,
    diagnostics = "nvim_lsp",

    diagnostics_indicator = function(count, level, diagnostics_dict, context)
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

-- Key mappings
u.map("n", "C-h>", "<Cmd>BufferLineCyclePrev<CR>")
u.map("n", "C-l>", "<Cmd>BufferLineCycleNext<CR>")
u.map("n", "Leader>bc", "<Cmd>BufferLinePickClose<CR>")
u.map("n", "Leader>be", "<Cmd>BufferLineSortByExtension<CR>")
u.map("n", "Leader>bl", "<Cmd>BufferLineMovePrev<CR>")
u.map("n", "Leader>br", "<Cmd>BufferLineMoveNext<CR>")
-- Go to buffer in position
u.map("n", "<Leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>")
u.map("n", "<Leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>")
u.map("n", "<Leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>")
u.map("n", "<Leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>")
u.map("n", "<Leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>")
u.map("n", "<Leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>")
u.map("n", "<Leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>")
u.map("n", "<Leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>")
u.map("n", "<Leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>")
