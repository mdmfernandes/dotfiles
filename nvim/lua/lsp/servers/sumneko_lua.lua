-- Lua language server: https://github.com/sumneko/lua-language-server
local u = require("lsp.utils")

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local settings = {
    Lua = {
        runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- Setup your lua path
            path = runtime_path,
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
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
            enable = false,
        },
    },
}

local S = {}

function S.setup()
    require("lspconfig").sumneko_lua.setup({
        flags = u.flags(),
        capabilities = u.capabilities(),
        on_attach = function(client, buf)
            u.attach_common(client, buf)
            u.format_document(client, buf)
        end,
        settings = settings,
    })
end

return S
