-- Sort lines uniquely
local F = {}

function F.format(lines)
    table.sort(lines)
    return vim.fn.uniq(lines)
end

return F
