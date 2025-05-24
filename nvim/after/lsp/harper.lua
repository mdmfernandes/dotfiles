--- https://github.com/automattic/harper

---@type vim.lsp.Config
return {
    cmd = { "harper-ls", "--stdio" },
    filetypes = {
        "c",
        "cmake",
        "cpp",
        "cs",
        "dart",
        "gitcommit",
        "go",
        "haskell",
        "html",
        "kotlin",
        "java",
        "javascript",
        "lua",
        "mail",
        "markdown",
        "nix",
        "php",
        "python",
        "rst",
        "ruby",
        "rust",
        "scala",
        "sh",
        "swift",
        "text",
        "toml",
        "typescript",
        "typescriptreact",
        "typst",
        "zsh"
    },
    root_markers = { ".git" },
    settings = {
        ["harper-ls"] = {
            userDictPath = vim.fn.expand("~/.config/harper-ls/dictionary.txt"),
            fileDictPath = vim.fn.expand("~/.config/harper-ls/file-dictionaries"),
            linters = {
                BoringWords = true,
                SentenceCapitalization = false,
                ToDoHyphen = false,
            },
        },
    },
}
