-- LSP user commands
local C = {}

----------------------------
-- rust_analyzer commands --
----------------------------

local function get_rust_analyzer(bufnr)
    local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "rust_analyzer" })

    -- Worth checking in case the client detaches from the buffer
    if #clients == 0 then
        vim.notify("No rust-analyzer client is attached to this buffer", vim.log.levels.ERROR)
        return nil
    end

    if #clients > 1 then
        vim.notify("Multiple rust-analyzer clients are attached to this buffer", vim.log.levels.ERROR)
        return nil
    end

    return clients[1]
end

local function set_features(bufnr, features)
    local client = get_rust_analyzer(bufnr)
    if not client then
        return
    end

    -- Deep copy the live settings (client.settings is what the server pulls via workspace/configuration).
    -- Nested tables may be shared with the global vim.lsp.config, so mutating in place would leak
    -- these features into other projects' clients.
    local settings = vim.deepcopy(client.settings or {})
    settings["rust-analyzer"] = settings["rust-analyzer"] or {}
    settings["rust-analyzer"].cargo = settings["rust-analyzer"].cargo or {}
    settings["rust-analyzer"].cargo.features = features
    client.settings = settings

    -- Notify only this project client. rust-analyzer then re-pulls the config from client.settings.
    if not client:notify("workspace/didChangeConfiguration", { settings = settings }) then
        vim.notify("Could not send updated settings to rust-analyzer", vim.log.levels.ERROR)
        return
    end

    -- Notify set features
    local feature_list = features == "all" and "all" or ("[" .. table.concat(features, ", ") .. "]")
    vim.notify("Set Cargo features to " .. feature_list)
end

local function list_features(bufnr)
    local client = get_rust_analyzer(bufnr)
    if not client then
        return
    end

    local settings = client.settings or {}
    local rust_settings = settings["rust-analyzer"]
    local cargo = type(rust_settings) == "table" and rust_settings.cargo or nil
    local features = type(cargo) == "table" and cargo.features or nil

    if features == "all" then
        vim.notify("All Cargo features enabled")
    elseif type(features) == "table" then
        vim.notify("Cargo features: [" .. table.concat(features, ", ") .. "]")
    elseif features == nil then
        vim.notify("Using default Cargo features")
    else
        vim.notify("Unexpected Cargo features value", vim.log.levels.WARN)
    end
end

local function create_rust_commands(bufnr)
    local existing = vim.api.nvim_buf_get_commands(bufnr, {})

    if not existing.RustFtSet then
        vim.api.nvim_buf_create_user_command(bufnr, "RustFtSet", function(opts)
            set_features(bufnr, opts.fargs)
        end, { desc = "Set rust-analyzer Cargo features for this project", nargs = "*" })
    end

    if not existing.RustFtSetAll then
        vim.api.nvim_buf_create_user_command(bufnr, "RustFtSetAll", function()
            set_features(bufnr, "all")
        end, { desc = "Enable all rust-analyzer Cargo features for this project", nargs = 0 })
    end

    if not existing.RustFtList then
        vim.api.nvim_buf_create_user_command(bufnr, "RustFtList", function()
            list_features(bufnr)
        end, { desc = "List rust-analyzer Cargo features for this project", nargs = 0 })
    end
end

function C.setup(client, bufnr)
    if client.name == "rust_analyzer" then
        create_rust_commands(bufnr)
    end
end

return C
