--- https://github.com/golang/tools/tree/master/gopls

---@type vim.lsp.Config
return {
    cmd = { "gopls" },
    filetypes = {
        "go",
        "gomod",
        "gowork",
        "gotmpl",
    },
    root_markers = { "go.work", "go.mod" },
    -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
    settings = {
        gopls = {
            gofumpt = true,
            -- Enable code lenses
            codelenses = {
                gc_details = true,
                generate = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
            },
            -- Enable all inlay hints
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            -- Enable all analyses except "shadow"
            -- See: https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
            analyses = {
                unusedvariable = true,
                useany = true,
            },
            staticcheck = true,
            semanticTokens = true,
            directoryFilters = { "-.git", "-node_modules" },
        },
    },
    flags = {
        debounce_text_changes = 200,
    },
}
