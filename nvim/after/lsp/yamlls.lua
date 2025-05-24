--- https://github.com/redhat-developer/yaml-language-server

---@type vim.lsp.Config
return {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
    root_markers = { ".git" },
    settings = {
        yaml = {
            validate = true,
            schemaStore = {
                enable = false,
                url = "",
            },
            schemas = {
                ["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] =
                "docker-compose*.{yml,yaml}",
                ["https://raw.githubusercontent.com/pycontribs/zuul-lint/master/zuul_lint/zuul-schema.json"] =
                { "*zuul.d/*.yaml", "*/.zuul.yaml" },
            },
        },
        -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
        redhat = { telemetry = { enabled = false } },
    },
}
