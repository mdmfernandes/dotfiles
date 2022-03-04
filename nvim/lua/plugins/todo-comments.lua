-- Todo comments: https://github.com/folke/todo-comments.nvim
local u = require("core.utils")

require("todo-comments").setup()

-- Key mappings
u.map("n", "<Leader>ft", "<Cmd>TodoTelescope<CR>")
