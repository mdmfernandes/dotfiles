--- https://github.com/bash-lsp/bash-language-server

---@type vim.lsp.Config
return {
    cmd = { "bash-language-server", "start" },
    filetypes = { "bash", "sh", "zsh" },
    root_markers = { ".git" },
    settings = {
        bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command)",
        },
    },
}
