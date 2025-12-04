--- https://github.com/microsoft/vscode-json-languageservice

---@type vim.lsp.Config
return {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    root_markers = { ".git" },
    -- Enable built-in formatter
    init_options = {
        provideFormatter = true,
    },
    settings = {
        json = {
            validate = { enable = true },
            schemas = {
                {
                    fileMatch = { "CMakePresets.json", "CMakeUserPresets.json" },
                    url = "https://cmake.org/cmake/help/latest/_downloads/3e2d73bff478d88a7de0de736ba5e361/schema.json",
                },
                {
                    fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
                    url = "https://www.schemastore.org/prettierrc.json",
                },
            },
        },
    },
    capabilities = {
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true,
                },
            },
        },
    },
}
