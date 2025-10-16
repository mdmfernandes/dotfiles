--- https://github.com/bergercookie/asm-lsp

---@type vim.lsp.Config
return {
    cmd = { "asm-lsp" },
    filetypes = { "asm", "vmasm" },
    root_markers = { ".asm-lsp.toml", ".git" },
}
