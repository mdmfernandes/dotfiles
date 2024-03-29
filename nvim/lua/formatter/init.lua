-- Formatter: format current buffer content using different formatters
-- Author: mdmfernandes

local F = {}

local formatters = {
    "count",
    "selinux",
    "sortuniq",
}

-- Returns a string with all formatters
local function formatters_str()
    return table.concat(formatters, ", ")
end

-- Complete function for the Format command
function F.complete(_, CmdLine, _)
    -- Split the CmdLine by space
    local args = {}
    for arg in string.gmatch(CmdLine, "%S+") do
        table.insert(args, arg)
    end

    -- Remove the first argument, which is the command name
    table.remove(args, 1)

    -- Remove formatters that are already used
    local unused_formatters = {}
    for _, formatter in ipairs(formatters) do
        if not vim.tbl_contains(args, formatter) then
            table.insert(unused_formatters, formatter)
        end
    end

    -- Return the filtered list of unused formatters
    return unused_formatters
end

-- Setup the Format command
function F.setup(args)
    -- Check if there are arguments
    if #args == 0 then
        vim.notify("Formatters: " .. formatters_str(), vim.log.levels.INFO)
        return
    end

    -- Check if all arguments are valid, i.e. are formatters
    local invalid = {}
    for i = 1, #args do
        if not vim.tbl_contains(formatters, args[i]) then
            table.insert(invalid, args[i])
        end
    end

    if #invalid > 0 then
        vim.notify(
            "Invalid formatter(s): " .. table.concat(invalid, ", ") .. "\nAvailable: " .. formatters_str(),
            vim.log.levels.ERROR)
        return
    end

    vim.notify("Formatting with: " .. table.concat(args, " ⇨ "), vim.log.levels.INFO)

    -- Read buffer content
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    -- Run the formatters in the order they were provided
    for i = 1, #args do
        lines = require("formatter.formatters." .. args[i]).format(lines)
    end

    -- Set the modified lines back into the buffer
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

return F
