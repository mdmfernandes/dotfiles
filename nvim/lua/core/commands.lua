-- User commands

-- Format current buffer with the provided parser
local parser = require("parser")

vim.api.nvim_buf_create_user_command(0, "Parse", function(opts)
    parser.setup(opts.fargs)
end, {
    nargs = "*",
    complete = function(ArgLead, CmdLine, CursorPos)
        return parser.complete(ArgLead, CmdLine, CursorPos)
    end,
})

-----------------------
-- Vim Pack commands --
-----------------------

-- :PackList - list all installed plugins
vim.api.nvim_create_user_command("PackList", function()
    local plugins = vim.pack.get()
    if #plugins == 0 then
        vim.notify("No plugins installed", vim.log.levels.INFO)
        return
    end

    local lines = {}
    for _, plugin in ipairs(plugins) do
        table.insert(lines, (plugin.active and "✓ " or "✗ ") .. plugin.spec.name)
    end

    vim.ui.select(lines, { prompt = "Installed plugins:" }, function() end)
end, { desc = "List all installed vim.pack plugins" })

-- :PackUpdate - update all plugins without confirmation
vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update(nil, { force = true })
end, { desc = "Update all vim.pack plugins (no confirmation)" })

-- :PackDelete - delete the provided plugin
vim.api.nvim_create_user_command("PackDelete", function(args)
    vim.pack.del(args.fargs, { force = true })
end, {
    nargs = "+",
    complete = function()
        return vim
            .iter(vim.pack.get())
            :map(function(p)
                return p.spec.name
            end)
            :totable()
    end,
})

-- :PackClean - remove unused plugins that are still installed
vim.api.nvim_create_user_command("PackClean", function()
    local installed = vim.pack.get()
    local orphans = {}
    for _, plugin in ipairs(installed) do
        if not plugin.active then
            table.insert(orphans, plugin.spec.name)
        end
    end

    if #orphans == 0 then
        vim.notify("No unused plugins found", vim.log.levels.INFO)
        return
    end

    vim.ui.select(
        { "Yes", "No" },
        { prompt = "Remove " .. #orphans .. " unused plugin(s): " .. table.concat(orphans, ", ") .. "?" },
        function(choice)
            if choice == "Yes" then
                vim.pack.del(orphans)
                vim.notify("Removed " .. #orphans .. " plugin(s)", vim.log.levels.INFO)
            end
        end
    )
end, { desc = "Remove unused vim.pack plugins" })
