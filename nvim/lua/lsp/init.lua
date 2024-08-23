-- LSP configuration
local LSP = {}

-- Language servers
-- All servers with custom options must be listed in this table.
-- Servers without custom options don't need to be in the table
-- and can be installed with `mason`. They can still be placed
-- in the table (so I don't forget which ones I typically use)
-- as `server_name = true` or `server_name = {}`.
local servers = {
    bashls = true,
    clangd = {
        keys = {
            { "<Leader>ch", "<Cmd>ClangdSwitchSourceHeader<CR>", desc = "Switch Source/Header (C/C++)" },
        },
        root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
                "Makefile",
                "configure.ac",
                "configure.in",
                "config.h.in",
                "meson.build",
                "meson_options.txt",
                "build.ninja"
            )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
                fname
            ) or require("lspconfig.util").find_git_ancestor(fname)
        end,
        capabilities = {
            offsetEncoding = { "utf-16" },
        },
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            "--fallback-style=llvm",
            "--function-arg-placeholders",
            "--header-insertion=iwyu",
            "--suggest-missing-includes",
        },
        init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
        },
    },
    gopls = {
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
                analyses = {
                    fieldalignment = true,
                    nilness = true,
                    unusedparams = true,
                    unusedvariable = true,
                    unusedwrite = true,
                    useany = true,
                },
                staticcheck = true,
                semanticTokens = true,
                directoryFilters = { "-.git", "-node_modules" },
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
    pyright = { -- Python static type checker. Replaces mypy (to a certain degree)
        settings = {
            pyright = {
                -- Using Ruff's import organizer
                disableOrganizeImports = true,
            },
            python = {
                analysis = {
                    -- Ignore all files for analysis to exclusively use Ruff for linting
                    ignore = { "*" },
                },
            },
        },
    },
    ruff_lsp = true, -- Python linter and formatter. Replaces: flake8, pylint (to a certain degree), black
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                diagnostics = {
                    enable = false,
                }
            }
        }
    },
    yamlls = {
        settings = {
            yaml = {
                validate = true,
                schemaStore = {
                    enable = false,
                    url = "",
                },
                schemas = {
                    ["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] =
                    "docker-compose*.{yml,yaml}"
                },
            },
        },

    }
}

-- Operations to do when a LSP client is attached
function LSP.on_attach(client, bufnr)
    -- Setup key mappings
    require("lsp.mappings").setup(client, bufnr)

    -- Setup highlight
    require("lsp.highlighter").setup(client, bufnr)

    -- Setup code lenses
    require("lsp.codelens").setup(client, bufnr)

    -- Setup formatting
    -- Use conform.nvim to format, instead of vim.lsp.buf.format.
    -- It falls back to the LSP if conform.nvim has no available
    -- formatter for the current filetype. See plugin config for
    -- details.
    -- require("lsp.formatter").setup(client, bufnr)

    -- Setup code context (navic)
    require("lsp.context").setup(client, bufnr)

    -- Add server specific attachments below
    if client.name == "ruff_lsp" then
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
    end
end

-- Setup LSP client capabilities
LSP.capabilities = vim.lsp.protocol.make_client_capabilities()
-- Add nvim-cmp to the LS capabilities with cmp-nvim-lsp
local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_cmp_ok then
    LSP.capabilities.textDocument.completion.completionItem.snippetSupport = true
    LSP.capabilities = cmp_nvim_lsp.default_capabilities(LSP.capabilities)
end

-- Setup options for LSP clients
local opts = {
    on_attach = LSP.on_attach,
    capabilities = LSP.capabilities,
}

-- Setup LSP
function LSP.setup()
    -- LSP handlers
    require("lsp.handlers").setup()

    -- LSP inlay hints
    require("lsp.inlayhints").setup()

    -- LSP installer
    require("lsp.installer").setup(servers, opts)

    -- Set global mappings (enable/disable LSP, LspInfo, etc.)
    require("lsp.mappings").global_mappings()
end

return LSP
