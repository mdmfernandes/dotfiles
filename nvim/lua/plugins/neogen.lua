-- Neogen: https://github.com/danymat/neogen
local u = require("core.utils")

require("neogen").setup({
  snippet_engine = "luasnip",
  languages = {
    python = {
      template = {
        annotation_convention = "reST",
      },
    },
  },
})

-- Key mappings
u.map("n", "<Leader>nf", ":lua require('neogen').generate()<CR>")
u.map("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>")
