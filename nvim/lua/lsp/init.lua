-- LSP module
local d = require("core.defaults")
local u = require("core.utils")
local lsp = vim.lsp

-- Handlers
lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, d.border_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, d.border_opts)

-- Set things when the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Display hover information about the symbol under the cursor
  u.buf_map(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>")

  -- Display signature information about the symbol under the cursor
  u.buf_map(bufnr, "n", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>")
  if client.resolved_capabilities.signature_help then
    vim.cmd("autocmd CursorHoldI <buffer> lua vim.lsp.buf.signature_help()")
  end

  -- Jump to the definition of the symbol under the cursor
  u.buf_map(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")

  -- Jump to the declaration of the symbol under the cursor
  u.buf_map(bufnr, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")

  -- Jump to the definition of the type of the symbol under the cursor
  u.buf_map(bufnr, "n", "gt", "<Cmd>lua vim.lsp.buf.type_definition()<CR>")

  -- Rename all references to the symbol under the cursor
  u.buf_map(bufnr, "n", "<Leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>")

  --  List all the implementations for the symbol under the cursor
  u.map("n", "<Leader>li", "<Cmd>Telescope lsp_implementations<CR>")
  --u.buf_map(bufnr, "n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>")

  -- List all the references to the symbol under the cursor
  u.map("n", "<Leader>lr", "<Cmd>Telescope lsp_references<CR>")
  --u.map(bufnr, "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>")

  -- List code actions available at the current cursor position
  u.map("n", "<Leader>ca", "<Cmd>Telescope lsp_code_actions<CR>")
  -- 	u.buf_map(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")

  -- Format the document
  u.buf_map(bufnr, "n", "<Leader>f", "<Cmd>lua vim.lsp.buf.formatting()<CR>")
  if client.resolved_capabilities.document_formatting then
    -- Format on save
    vim.cmd([[
        augroup LspFormatting
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
        ]])
  end

  -- Diagnostics key mappings
  u.buf_map(bufnr, "n", "<Leader>dd", "<Cmd>lua vim.diagnostic.open_float()<CR>")
  u.buf_map(bufnr, "n", "<Leader>dp", "<Cmd>lua vim.diagnostic.goto_prev()<CR>")
  u.buf_map(bufnr, "n", "<Leader>dn", "<Cmd>lua vim.diagnostic.goto_next()<CR>")
  u.buf_map(bufnr, "n", "<Leader>dq", "<Cmd>lua vim.diagnostic.setq list()<CR>")
  u.buf_map(bufnr, "n", "<Leader>dl", "<Cmd>Telescope diagnostics<CR>")
end

-- Extend the language server capabilities with nvim-cmp: https://github.com/hrsh7th/cmp-nvim-lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

for _, server in
  ipairs({
    "bashls",
    "gopls",
    "null-ls",
    "pyright",
    "sumneko_lua",
  })
do
  require("lsp." .. server).setup(on_attach, capabilities)
end
