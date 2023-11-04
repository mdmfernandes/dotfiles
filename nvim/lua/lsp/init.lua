-- LSP configuration
local LSP = {}

-- Language servers
-- All servers with custom options must be listed in this table.
-- Servers without custom options don't need to be in the table
-- and can be installed with `mason`. They can still be placed
-- in the table (for some reason) as `server_name = true` or
-- `server_name = {}`.
local servers = {
    bashls = true,
    clangd = {
        cmd = { "clangd",
            "--background-index",
            "--suggest-missing-includes",
            "--clang-tidy",
            "--offset-encoding=utf-16"
        },
    },
    gopls = {
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
            },
        },
        flags = {
            debounce_text_changes = 200,
        }
    },
    jsonls = true,
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using,
                    -- most likely LuaJIT in the case of Neovim
                    version = "LuaJIT",
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { "vim" },
                    neededFileStatus = {
                        ["codestyle-check"] = "Any",
                    },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                format = {
                    enable = true,
                    defaultConfig = {
                        indent_style = "space",
                        indent_size = "4",
                        max_line_length = "120",
                        quote_style = "double",
                    },
                },
                completion = {
                    callSnippet = "Replace"
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            }
        }
    },
    pyright = true,
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                diagnostics = {
                    enable = false,
                }
            }
        }
    },
}

-- Operations to do when a LSP server is attached
function LSP.on_attach(client, bufnr)
    -- Setup key mappings
    require("lsp.mappings").setup(client, bufnr)

    -- Setup highlight
    require("lsp.highlighter").setup(client, bufnr)

    -- Setup formatting
    require("lsp.formatter").setup(client, bufnr)

    -- Setup code context (navic)
    require("lsp.context").setup(client, bufnr)

    -- Add server specific attachments below
end

-- Setup LSP server capabilities
LSP.capabilities = vim.lsp.protocol.make_client_capabilities()
-- Add nvim-cmp to the LS capabilities with cmp-nvim-lsp
local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_cmp_ok then
    LSP.capabilities.textDocument.completion.completionItem.snippetSupport = true
    LSP.capabilities = cmp_nvim_lsp.default_capabilities(LSP.capabilities)
end

-- Setup options for LSP servers
local opts = {
    on_attach = LSP.on_attach,
    capabilities = LSP.capabilities,
}

-- Setup LSP
function LSP.setup()
    -- LSP handlers
    require("lsp.handlers").setup()

    -- none-ls
    require("lsp.none-ls").setup(opts)

    -- LSP installer
    require("lsp.installer").setup(servers, opts)

    -- Set global mappings (enable/disable LSP, LspInfo, etc.)
    require("lsp.mappings").global_mappings()
end

return LSP
