--- https://github.com/microsoft/pyright

---@type vim.lsp.Config
return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    init_options = {
        -- See: https://docs.astral.sh/ruff/editors/settings/
        settings = {
            pyright = {
                disableOrganizeImports = true,
            },
        },
    },
}
