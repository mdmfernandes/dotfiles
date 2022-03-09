-- autopairs: https://github.com/windwp/nvim-autopairs
require("nvim-autopairs").setup({
    -- Use treesitter to check for pairs
    check_ts = true,
})

-- Use autopairs in completions. E.g. in Python when we complete `print`, it becomes `print()`
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
