-- Sort lines uniquely
local P = {}

function P.parse(lines)
    table.sort(lines)
    return vim.fn.uniq(lines)
end

return P
