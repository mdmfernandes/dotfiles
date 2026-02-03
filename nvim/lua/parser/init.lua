-- Parser: parse current buffer content using different parsers
-- Author: mdmfernandes

local F = {}

local parsers = {
    "count",
    "selinux",
    "sortuniq",
}

-- Returns a string with all parsers
local function parsers_str()
    return table.concat(parsers, ", ")
end

-- Complete function for the `Parse` command
function F.complete(_, CmdLine, _)
    -- Split the CmdLine by space
    local args = {}
    for arg in string.gmatch(CmdLine, "%S+") do
        table.insert(args, arg)
    end

    -- Remove the first argument, which is the command name
    table.remove(args, 1)

    -- Remove parsers that are already used
    local unused_parsers = {}
    for _, parser in ipairs(parsers) do
        if not vim.tbl_contains(args, parser) then
            table.insert(unused_parsers, parser)
        end
    end

    -- Return the filtered list of unused parsers
    return unused_parsers
end

-- Setup the `Parse` command
function F.setup(args)
    -- Check if there are arguments
    if #args == 0 then
        vim.notify("Parsers: " .. parsers_str(), vim.log.levels.INFO)
        return
    end

    -- Check if all arguments are valid, i.e. are parsers
    local invalid = {}
    for i = 1, #args do
        if not vim.tbl_contains(parsers, args[i]) then
            table.insert(invalid, args[i])
        end
    end

    if #invalid > 0 then
        vim.notify(
            "Invalid parser(s): " .. table.concat(invalid, ", ") .. "\nAvailable: " .. parsers_str(),
            vim.log.levels.ERROR
        )
        return
    end

    vim.notify("Parsing with: " .. table.concat(args, " ⇨ "), vim.log.levels.INFO)

    -- Read buffer content
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    -- Run the parsers in the order they were provided
    for i = 1, #args do
        lines = require("parser.parsers." .. args[i]).parse(lines)
    end

    -- Set the modified lines back into the buffer
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

return F
