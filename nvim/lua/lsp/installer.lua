-- LSP installer: install servers
local I = {}

function I.setup(servers, global_opts)
    -- Load lspconfig
    local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
    if not lspconfig_status_ok then
        return
    end

    local icons = require("icons").lsp
    -- Load mason
    require("mason").setup({
        ui = {
            icons = {
                package_installed = icons.source_installed,
                package_pending = icons.source_pending,
                package_uninstalled = icons.source_uninstalled
            }
        }
    })

    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
        -- Ensure that the following LSP servers are always installed
        ensure_installed = { "bashls", "jsonls" }
    })

    mason_lspconfig.setup_handlers({
        -- Default function for LSP servers
        function(server)
            local server_opts = servers[server]

            -- If the server options are not a table (e.g. server_name = true), convert to an empty table
            if type(server_opts) ~= "table" then
                server_opts = {}
            end

            local opts = vim.tbl_deep_extend("force", global_opts, server_opts)

            lspconfig[server].setup(opts)
        end,

        -- Add specific server configurations below
        -- lua-ls -> setup neodev
        ["lua_ls"] = function()
            local opts = vim.tbl_deep_extend("force", global_opts, servers["lua_ls"])
            require("neodev").setup {}
            lspconfig.lua_ls.setup(opts)
        end,

    })
end

return I
