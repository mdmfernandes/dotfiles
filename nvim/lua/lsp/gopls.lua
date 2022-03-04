-- Google's lsp server for golang: https://github.com/golang/tools/tree/master/gopls
local settings = {
  gopls = {
    analyses = {
      unusedparams = true,
    },
    staticcheck = true,
  },
}

local M = {}

M.setup = function(on_attach, capabilities)
  require("lspconfig").gopls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = settings,
    cmd = { "gopls", "serve" },
    filetypes = { "go", "gomod", "gotmpl" },
    root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
  })
end

return M
