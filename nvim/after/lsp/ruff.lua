--- https://docs.astral.sh/ruff/

---@type vim.lsp.Config
return {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    init_options = {
        -- See: https://docs.astral.sh/ruff/editors/settings/
        settings = {
            organizeImports = true,
        },
    },
}
